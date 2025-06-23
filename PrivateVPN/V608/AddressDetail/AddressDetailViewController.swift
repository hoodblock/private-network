//
//  AddressDetailViewController.swift
//  V608
//
//  Created by Thomas on 2024/9/6.
//

import UIKit
import MapKit

enum AddressViewSource: Int {
    case main = 0
    case connectSuccess = 1
    case connectDisconnect = 2
}

class AddressHeaderView: UIView {
    
    var viewBlock: ViewBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backButton)
        addSubview(titleLabel_1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backButton.frameLeft = fitViewHeight(20)
        titleLabel_1.frameCenterX = frameWidth / 2
        backButton.frameCenterY = frameHeight / 2
        titleLabel_1.frameCenterY = backButton.frameCenterY
    }
    
    lazy var titleLabel_1: UILabel = {
        let resultView = UILabel()
        resultView.text = "Address"
        resultView.font = UIFont.fitFont(.semiBold, 18)
        resultView.textColor = UIColor(red: 16/255, green: 16/255, blue: 16/255, alpha: 1)
        resultView.sizeToFit()
        return resultView
    }()
    
    lazy var backButton: UIButton = {
        let resultView = UIButton(type: .custom)
        resultView.setImage(UIImage(named: "back_left_black_icon"), for: .normal)
        resultView.frameSize = CGSize(width: fitViewHeight(30), height: fitViewHeight(30))
        resultView.addTarget(self, action: #selector(buttonDidClick), for: .touchUpInside)
        return resultView
    }()
    
    @objc func buttonDidClick(_ sender: UIButton) {
        if viewBlock != nil {
            viewBlock!()
        }
    }
}

class AddressDetailViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var source: AddressViewSource = .main
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.addSubview(addressMapView)
        view.addSubview(headerView)
        view.addSubview(addressBackView)
        view.addSubview(addressBackIconImageView)
        view.addSubview(addressBackLabel_0)
        view.addSubview(addressBackLabel_1)
        view.addSubview(timeBackView)
        view.addSubview(timeBackIconImageView)
        view.addSubview(timeBackLabel_0)
        view.addSubview(timeBackLabel_1)
        view.addSubview(cityBackView)
        view.addSubview(cityBackIconImageView)
        view.addSubview(cityBackLabel_0)
        view.addSubview(cityBackLabel_1)
        view.addSubview(latBackView)
        view.addSubview(latBackLabel_0)
        view.addSubview(latBackLabel_1)
        view.addSubview(lonBackView)
        view.addSubview(lonBackLabel_0)
        view.addSubview(lonBackLabel_1)
        view.addSubview(indicatorView)
        NotificationCenter.default.addObserver(self, selector: #selector(handleFreeTimeNotification), name: .freeTimeNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        localManager.requestWhenInUseAuthorization()
        loadLocalManager()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: .freeTimeNotification, object: nil)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        indicatorView.frameSize = CGSize(width: fitViewHeight(50), height: fitViewHeight(50))
        indicatorView.center = view.center
        addressMapView.frameSize = self.view.frameSize
        headerView.frameSize = CGSize(width: view.frameWidth, height: fitViewHeight(50))
        headerView.frameTop = self.view.safeAreaInsets.top
        addressBackView.frameWidth = (view.frameWidth - fitViewHeight(20) * 3) / 2
        timeBackView.frameWidth = (view.frameWidth - fitViewHeight(20) * 3) / 2
        addressBackView.frameHeight = addressBackView.frameWidth * 1
        timeBackView.frameHeight = timeBackView.frameWidth * 0.8
        addressBackView.frameLeft = fitViewHeight(20)
        timeBackView.frameRight = view.frameWidth - fitViewHeight(20)
        addressBackView.frameBottom = self.view.frameHeight - self.view.safeAreaInsets.bottom
        timeBackView.frameBottom = addressBackView.frameBottom
        addressBackIconImageView.frameLeft = addressBackView.frameLeft + fitViewHeight(20)
        addressBackIconImageView.frameTop = addressBackView.frameTop + fitViewHeight(10)
        addressBackLabel_0.frameLeft = addressBackView.frameLeft + fitViewHeight(20)
        addressBackLabel_0.frameTop = addressBackIconImageView.frameBottom + fitViewHeight(10)
        addressBackLabel_1.frameCenterX = addressBackView.frameCenterX
        addressBackLabel_1.frameBottom = addressBackView.frameBottom - fitViewHeight(20)
        timeBackIconImageView.frameLeft = timeBackView.frameLeft + fitViewHeight(20)
        timeBackIconImageView.frameTop = timeBackView.frameTop + fitViewHeight(10)
        timeBackLabel_0.frameLeft = timeBackIconImageView.frameLeft
        timeBackLabel_0.frameTop = timeBackIconImageView.frameBottom + fitViewHeight(10)
        timeBackLabel_1.frameCenterX = timeBackView.frameCenterX
        timeBackLabel_1.frameBottom = timeBackView.frameBottom - fitViewHeight(20)
        lonBackView.frameSize = CGSize(width: fitViewHeight(100), height: fitViewHeight(80))
        lonBackView.frameBottom = addressBackView.frameTop - fitViewHeight(30)
        lonBackView.frameRight = view.frameWidth - fitViewHeight(20)
        lonBackLabel_0.frameCenterX = lonBackView.frameCenterX
        lonBackLabel_1.frameCenterX = lonBackView.frameCenterX
        lonBackLabel_0.frameBottom = lonBackView.frameCenterY - fitViewHeight(5)
        lonBackLabel_1.frameTop = lonBackView.frameCenterY + fitViewHeight(5)
        latBackView.frameSize = CGSize(width: fitViewHeight(100), height: fitViewHeight(80))
        latBackView.frameBottom = lonBackView.frameTop - fitViewHeight(30)
        latBackView.frameRight = view.frameWidth - fitViewHeight(20)
        latBackLabel_0.frameCenterX = latBackView.frameCenterX
        latBackLabel_1.frameCenterX = latBackView.frameCenterX
        latBackLabel_0.frameBottom = latBackView.frameCenterY - fitViewHeight(5)
        latBackLabel_1.frameTop = latBackView.frameCenterY + fitViewHeight(5)
        cityBackView.frameSize = CGSize(width: fitViewHeight(100), height: fitViewHeight(130))
        cityBackView.frameBottom = latBackView.frameTop - fitViewHeight(30)
        cityBackView.frameRight = view.frameWidth - fitViewHeight(20)
        cityBackIconImageView.frameCenterX = cityBackView.frameCenterX
        cityBackLabel_0.frameCenterX = cityBackView.frameCenterX
        cityBackLabel_1.frameCenterX = cityBackView.frameCenterX
        cityBackIconImageView.frameTop = cityBackView.frameTop + fitViewHeight(20)
        cityBackLabel_1.frameBottom = cityBackView.frameBottom - fitViewHeight(20)
        cityBackLabel_0.frameBottom = cityBackLabel_1.frameTop - fitViewHeight(10)
    }
  
    lazy var addressMapView: MKMapView = {
        let resultView = MKMapView()
        resultView.userTrackingMode = .follow
        resultView.isZoomEnabled = true
        resultView.delegate = self
        return resultView
    }()
    
    lazy var localManager: CLLocationManager = {
        let result = CLLocationManager()
        result.activityType = .fitness
        result.delegate = self
        result.desiredAccuracy = kCLLocationAccuracyBest
        return result
    }()

    lazy var headerView: AddressHeaderView = {
        let resultView = AddressHeaderView()
        resultView.viewBlock = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        return resultView
    }()
    
    lazy var addressBackView: UIView = {
        let resultView = UIView()
        resultView.backgroundColor = UIColor(red: 138/255, green: 255/255, blue: 232/255, alpha: 1)
        resultView.layer.cornerRadius = fitViewHeight(25)
        resultView.layer.masksToBounds = true
        return resultView
    }()
    
    lazy var addressBackIconImageView: UIImageView = {
        let resultView = UIImageView()
        resultView.image = UIImage(named: "address_detail_icon")
        resultView.frameSize = CGSize(width: fitViewHeight(40), height: fitViewHeight(30))
        return resultView
    }()
    
    lazy var addressBackLabel_0: UILabel = {
        let resultView = UILabel()
        resultView.text = "IP Address"
        resultView.font = UIFont.fitFont(.regular, 12)
        resultView.textColor = UIColor(red: 16/255, green: 16/255, blue: 16/255, alpha: 1)
        resultView.sizeToFit()
        return resultView
    }()
    
    lazy var addressBackLabel_1: UILabel = {
        let resultView = UILabel()
        resultView.text = RequestManager.shared.currentRegionItem.regionIP
        resultView.font = UIFont.fitFont(.bold, 18)
        resultView.textColor = UIColor(red: 16/255, green: 16/255, blue: 16/255, alpha: 1)
        resultView.sizeToFit()
        return resultView
    }()
    
    lazy var timeBackView: UIView = {
        let resultView = UIView()
        resultView.backgroundColor = UIColor(red: 164/255, green: 164/255, blue: 164/255, alpha: 0.6)
        resultView.layer.cornerRadius = fitViewHeight(25)
        resultView.layer.masksToBounds = true
        return resultView
    }()
    
    lazy var timeBackIconImageView: UIImageView = {
        let resultView = UIImageView()
        resultView.image = UIImage(named: "address_detail_time_icon")
        resultView.frameSize = CGSize(width: fitViewHeight(30), height: fitViewHeight(30))
        return resultView
    }()
    
    lazy var timeBackLabel_0: UILabel = {
        let resultView = UILabel()
        resultView.text = "Remaining Time"
        resultView.font = UIFont.fitFont(.regular, 12)
        resultView.textColor = UIColor(red: 16/255, green: 16/255, blue: 16/255, alpha: 1)
        resultView.sizeToFit()
        return resultView
    }()
    
    lazy var timeBackLabel_1: UILabel = {
        let resultView = UILabel()
        resultView.text = NetworkManager.shared.formatTime()
        resultView.font = UIFont.fitFont(.bold, 16)
        resultView.textColor = UIColor(red: 16/255, green: 16/255, blue: 16/255, alpha: 1)
        resultView.sizeToFit()
        return resultView
    }()
    
    lazy var cityBackView: UIView = {
        let resultView = UIView()
        resultView.backgroundColor = UIColor(red: 164/255, green: 164/255, blue: 164/255, alpha: 0.6)
        resultView.layer.cornerRadius = fitViewHeight(25)
        resultView.layer.masksToBounds = true
        return resultView
    }()
    
    lazy var cityBackIconImageView: UIImageView = {
        let resultView = UIImageView()
        let zdjcn = RequestManager.shared.currentRegionItem.regionIcon
        resultView.image = UIImage(named: RequestManager.shared.currentRegionItem.regionIcon ?? "")
        resultView.frameSize = CGSize(width: fitViewHeight(60), height: fitViewHeight(40))
        resultView.layer.cornerRadius = fitViewHeight(5)
        resultView.layer.masksToBounds = true
        return resultView
    }()
    
    lazy var cityBackLabel_0: UILabel = {
        let resultView = UILabel()
        resultView.text = RequestManager.shared.currentRegionItem.regionCountry
        resultView.font = UIFont.fitFont(.bold, 16)
        resultView.textColor = UIColor(red: 16/255, green: 16/255, blue: 16/255, alpha: 1)
        resultView.sizeToFit()
        return resultView
    }()
    
    lazy var cityBackLabel_1: UILabel = {
        let resultView = UILabel()
        resultView.text = RequestManager.shared.currentRegionItem.regionCity
        resultView.font = UIFont.fitFont(.regular, 12)
        resultView.textColor = UIColor(red: 16/255, green: 16/255, blue: 16/255, alpha: 1)
        resultView.sizeToFit()
        return resultView
    }()
    
    lazy var latBackView: UIView = {
        let resultView = UIView()
        resultView.backgroundColor = UIColor(red: 164/255, green: 164/255, blue: 164/255, alpha: 0.6)
        resultView.layer.cornerRadius = fitViewHeight(25)
        resultView.layer.masksToBounds = true
        return resultView
    }()
    
    lazy var latBackLabel_0: UILabel = {
        let resultView = UILabel()
        resultView.text = String(format: "%0.2f", (RequestManager.shared.currentRegionItem.regionLat as NSString).doubleValue)
        resultView.font = UIFont.fitFont(.bold, 16)
        resultView.textColor = UIColor(red: 16/255, green: 16/255, blue: 16/255, alpha: 1)
        resultView.sizeToFit()
        return resultView
    }()
    
    lazy var latBackLabel_1: UILabel = {
        let resultView = UILabel()
        resultView.text = "Latitude"
        resultView.font = UIFont.fitFont(.regular, 12)
        resultView.textColor = UIColor(red: 16/255, green: 16/255, blue: 16/255, alpha: 1)
        resultView.sizeToFit()
        return resultView
    }()
    
    lazy var lonBackView: UIView = {
        let resultView = UIView()
        resultView.backgroundColor = UIColor(red: 164/255, green: 164/255, blue: 164/255, alpha: 0.6)
        resultView.layer.cornerRadius = fitViewHeight(25)
        resultView.layer.masksToBounds = true
        return resultView
    }()
    
    lazy var lonBackLabel_0: UILabel = {
        let resultView = UILabel()
        resultView.text = String(format: "%0.2f", (RequestManager.shared.currentRegionItem.regionLon as NSString).doubleValue)
        resultView.font = UIFont.fitFont(.bold, 16)
        resultView.textColor = UIColor(red: 16/255, green: 16/255, blue: 16/255, alpha: 1)
        resultView.sizeToFit()
        return resultView
    }()
    
    lazy var lonBackLabel_1: UILabel = {
        let resultView = UILabel()
        resultView.text = "Longitude"
        resultView.font = UIFont.fitFont(.regular, 12)
        resultView.textColor = UIColor(red: 16/255, green: 16/255, blue: 16/255, alpha: 1)
        resultView.sizeToFit()
        return resultView
    }()
    
    lazy var indicatorView: UIActivityIndicatorView = {
        let resultView = UIActivityIndicatorView.init(style: .large)
        resultView.color = UIColor.black
        return resultView
    }()
}

extension AddressDetailViewController {
    
    func loadLocalManager() {
        let cllocaltion: CLLocation = CLLocation(latitude: (RequestManager.shared.currentRegionItem.regionLat as NSString).doubleValue, longitude: (RequestManager.shared.currentRegionItem.regionLon as NSString).doubleValue)
        let pointAnnotation: MKPointAnnotation = MKPointAnnotation()
        pointAnnotation.coordinate = cllocaltion.coordinate
        addressMapView.addAnnotation(pointAnnotation)
        addressMapView.setRegion(MKCoordinateRegion(center: cllocaltion.coordinate, latitudinalMeters: 2000, longitudinalMeters: 2000), animated: true)
        localManager.startUpdatingLocation()
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let pinAnnotationView: MKPinAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "pinAnnotationView") as? MKPinAnnotationView ?? MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pinAnnotationView")
        pinAnnotationView.pinTintColor = .red
        pinAnnotationView.animatesDrop = true
        pinAnnotationView.canShowCallout = true
        return pinAnnotationView;
    }
}

extension AddressDetailViewController {

    func loading() {
        indicatorView.startAnimating()
        view.bringSubviewToFront(indicatorView)
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 5) { [weak self] in
            self?.dismiss()
        }
    }

    func dismiss() {
        DispatchQueue.main.async { [weak self] in
            self?.indicatorView.stopAnimating()
        }
    }
      
}


extension AddressDetailViewController {
    
    // 免费使用时间的通知
    @objc func handleFreeTimeNotification() {
        DispatchQueue.main.async { [weak self] in
            self?.timeBackLabel_1.text = NetworkManager.shared.formatTime()
            self?.timeBackLabel_1.sizeToFit()
        }
    }
    
}
