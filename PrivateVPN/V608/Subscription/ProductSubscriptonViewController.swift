//
//  ProductSubscriptonViewController.swift
//  V608
//
//  Created by Thomas on 2024/9/14.
//

import UIKit


class ProductSubscriptonViewController : UIViewController {
    
    var viewBlock: ViewBlock?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        view.addSubview(backImageView)
        view.addSubview(buttonView_0)
        view.addSubview(titleLabel_0)
        view.addSubview(titleLabel_1)
        view.addSubview(titleLabel_2)
        view.addSubview(privilegesView_0)
        view.addSubview(privilegesView_1)
        view.addSubview(privilegesView_2)
        view.addSubview(subscriptionTypeView)
        view.addSubview(bottomButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        backImageView.frame = view.bounds
        bottomButton.frameSize = CGSize(width: view.frameWidth - fitViewHeight(20) * 2, height: fitViewHeight(52))
        bottomButton.frameCenterX = view.frameCenterX
        bottomButton.frameBottom = view.frameHeight - view.fitViewHeight(60)
        buttonView_0.frameRight = view.frameWidth - fitViewHeight(20)
        buttonView_0.frameTop = self.view.safeAreaInsets.top
        titleLabel_0.frameLeft = fitViewHeight(20)
        titleLabel_1.frameLeft = fitViewHeight(20)
        titleLabel_2.frameLeft = fitViewHeight(20)
        titleLabel_0.frameTop = buttonView_0.frameBottom + fitViewHeight(20)
        titleLabel_1.frameTop = titleLabel_0.frameBottom
        titleLabel_2.frameTop = titleLabel_1.frameBottom + fitViewHeight(10)
        let magin: CGFloat = (view.frameWidth - fitViewHeight(20) * 3) / 2
        privilegesView_0.frameSize = CGSize(width: magin, height: fitViewHeight(36))
        privilegesView_1.frameSize = CGSize(width: magin, height: fitViewHeight(36))
        privilegesView_2.frameSize = CGSize(width: magin, height: fitViewHeight(36))
        privilegesView_0.frameLeft = fitViewHeight(20)
        privilegesView_0.frameTop = titleLabel_2.frameBottom + fitViewHeight(20)
        privilegesView_1.frameCenterY = privilegesView_0.frameCenterY
        privilegesView_1.frameRight = view.frameWidth - fitViewHeight(20)
        privilegesView_2.frameLeft = fitViewHeight(20)
        privilegesView_2.frameTop = privilegesView_0.frameBottom + fitViewHeight(20)
        subscriptionTypeView.frameLeft = fitViewHeight(20)
        subscriptionTypeView.frameSize = CGSize(width: view.frameWidth - fitViewHeight(20) * 2, height: fitViewHeight(210))
        subscriptionTypeView.frameBottom = bottomButton.frameTop - fitViewHeight(50)
    }
    
    lazy var backImageView: UIImageView = {
        let resultView = UIImageView()
        resultView.image = UIImage(named: "vip_background_icon")
        return resultView
    }()
    
    lazy var buttonView_0: UIButton = {
        let resultView = UIButton(type: .custom)
        resultView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.2)
        resultView.setImage(UIImage(named: "close_gray_icon"), for: .normal)
        resultView.frameSize = CGSize(width: fitViewHeight(40), height: fitViewHeight(40))
        resultView.layer.cornerRadius = fitViewHeight(20)
        resultView.layer.masksToBounds = true
        resultView.addTarget(self, action: #selector(buttonDidClick_0), for: .touchUpInside)
        return resultView
    }()
    
    lazy var titleLabel_0: UILabel = {
        let resultView = UILabel()
        resultView.text = "VIP"
        resultView.font = UIFont.fitFont(.bold, 40)
        resultView.textColor = UIColor(red: 138/255, green: 255/255, blue: 232/255, alpha: 1)
        resultView.sizeToFit()
        return resultView
    }()
    
    lazy var titleLabel_1: UILabel = {
        let resultView = UILabel()
        resultView.text = "Membership"
        resultView.font = UIFont.fitFont(.bold, 40)
        resultView.textColor = UIColor(red: 138/255, green: 255/255, blue: 232/255, alpha: 1)
        resultView.sizeToFit()
        return resultView
    }()
    
    lazy var titleLabel_2: UILabel = {
        let resultView = UILabel()
        resultView.text = "Activate VIP membership and enjoy exclusive perks!"
        resultView.font = UIFont.fitFont(.regular, 14)
        resultView.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.6)
        resultView.heightAuthSize(view.frameWidth - fitViewHeight(20) * 2)
        resultView.numberOfLines = 0
        resultView.textAlignment = .left
        return resultView
    }()
    
    lazy var privilegesView_0: ImageTitleButton = {
        let resultView = ImageTitleButton()
        resultView.imageType = .leftImageRightTitle
        resultView.createTitleImageButton(title: "Remove Ads", titleColor: UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.6), titleFont: UIFont.fitFont(.medium, 13), imageName: "vip_remove_ad_default_icon", imageSize: CGSize(width: UIView.fitViewHeight(16), height: UIView.fitViewHeight(16)), cornerRadius: UIView.fitViewHeight(10), backgroundColor: UIColor(red: 89/255, green: 106/255, blue: 102/255, alpha: 1), magin: fitViewHeight(10))
        return resultView
    }()
    
    lazy var privilegesView_1: ImageTitleButton = {
        let resultView = ImageTitleButton()
        resultView.imageType = .leftImageRightTitle
        resultView.createTitleImageButton(title: "Premium Servers", titleColor: UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.6), titleFont: UIFont.fitFont(.medium, 13), imageName: "vip_good_address_default_icon", imageSize: CGSize(width: UIView.fitViewHeight(16), height: UIView.fitViewHeight(16)), cornerRadius: UIView.fitViewHeight(10), backgroundColor: UIColor(red: 89/255, green: 106/255, blue: 102/255, alpha: 1), magin: fitViewHeight(10))
        return resultView
    }()
    
    lazy var privilegesView_2: ImageTitleButton = {
        let resultView = ImageTitleButton()
        resultView.imageType = .leftImageRightTitle
        resultView.createTitleImageButton(title: "Top Regions", titleColor: UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.6), titleFont: UIFont.fitFont(.medium, 13), imageName: "vip_detail_local_default_icon", imageSize: CGSize(width: UIView.fitViewHeight(16), height: UIView.fitViewHeight(16)), cornerRadius: UIView.fitViewHeight(10), backgroundColor: UIColor(red: 89/255, green: 106/255, blue: 102/255, alpha: 1), magin: fitViewHeight(10))
        return resultView
    }()
   
    lazy var bottomButton: ImageTitleButton = {
        let resultView = ImageTitleButton()
        resultView.createTitleImageButton(title: "Get all privileges", titleColor: UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1), titleFont: UIFont.fitFont(.bold, 14), imageName: "to_right_black_icon", imageSize: CGSize(width: UIView.fitViewHeight(20), height: UIView.fitViewHeight(10)), cornerRadius: UIView.fitViewHeight(26), backgroundColor: UIColor(red: 40/255, green: 255/255, blue: 207/255, alpha: 1))
        resultView.viewBlock = { [weak self] in
          // 支付
        }
        return resultView
    }()
    
    lazy var subscriptionTypeView: ProductSubscriptionView = {
        let resultView = ProductSubscriptionView()
        return resultView
    }()
}

extension ProductSubscriptonViewController {
    
    @objc func buttonDidClick_0(_ sender: UIButton) {
       dismiss(animated: true)
    }
    
}
