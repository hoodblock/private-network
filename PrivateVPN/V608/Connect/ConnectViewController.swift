//
//  ConnectViewController.swift
//  V608
//
//  Created by Thomas on 2024/9/6.
//

import UIKit

/// 首页连接页面
class ConnectViewController : UIViewController {
    
    var viewBlock: ViewBlock?
    var addressCount: Int = 0
    var flowTimeCount: Int = 0
    var timer: Timer?
    
    private var timerNumber: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.addSubview(backImageView)
        view.addSubview(defaultHeaderView)
        view.addSubview(vipHeaderView)
        view.addSubview(noConnoctAnimationView)
        view.addSubview(connoctedAnimationView)
        view.addSubview(timeLabel)
        view.addSubview(titleLabel_0)
        view.addSubview(titleLabel_1)
        view.addSubview(timeView)
        timerNumber = 0
        NotificationCenter.default.addObserver(self, selector: #selector(handleFreeTimeNotification), name: .freeTimeNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        titleLabel_0.text = RequestManager.shared.currentSelectedRegionItem.regionCountry
        titleLabel_1.text = RequestManager.shared.currentSelectedRegionItem.regionCity
        titleLabel_0.sizeToFit()
        titleLabel_1.sizeToFit()
        if NetworkManager.shared.status == .connected {
            self.timeView.isHidden = false
            self.noConnoctAnimationView.isHidden = true
            self.connoctedAnimationView.isHidden = false
        } else {
            self.timeView.isHidden = true
            self.noConnoctAnimationView.isHidden = false
            self.connoctedAnimationView.isHidden = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        backImageView.frame = view.bounds
        defaultHeaderView.frameSize = CGSize(width: view.frameWidth, height: fitViewHeight(45))
        defaultHeaderView.frameTop = self.view.safeAreaInsets.top
        vipHeaderView.frameSize = CGSize(width: view.frameWidth, height: fitViewHeight(50))
        vipHeaderView.frameTop = self.view.safeAreaInsets.top
        noConnoctAnimationView.frameSize = CGSize(width: fitViewHeight(110), height: fitViewHeight(200))
        noConnoctAnimationView.frameCenterX = self.view.frameWidth / 2
        noConnoctAnimationView.frameCenterY = self.view.frameHeight / fitViewHeight(2.1)
        connoctedAnimationView.frameSize = CGSize(width: fitViewHeight(110), height: fitViewHeight(200))
        connoctedAnimationView.frameCenterX = self.view.frameWidth / 2
        connoctedAnimationView.frameCenterY = self.view.frameHeight / fitViewHeight(2.1)
        timeLabel.frameCenterX = view.frameWidth / 2
        timeLabel.frameTop = noConnoctAnimationView.frameBottom + fitViewHeight(20)
        titleLabel_0.frameCenterX = self.view.frameWidth / 2
        titleLabel_1.frameCenterX = self.view.frameWidth / 2
        titleLabel_0.frameTop = timeLabel.frameBottom + fitViewHeight(20)
        titleLabel_1.frameTop = titleLabel_0.frameBottom + fitViewHeight(20)
        timeView.frameSize = CGSize(width: view.frameWidth, height: view.frameWidth * 66 / 171)
        timeView.frameBottom = self.view.frameHeight - self.view.safeAreaInsets.bottom - fitViewHeight(42)
    }
    
    lazy var backImageView: UIImageView = {
        let resultView = UIImageView()
        resultView.image = UIImage(named: "connect_back_ground_icon")
        return resultView
    }()
    
    lazy var defaultHeaderView: ConnectDefaultHeaderView = {
        let resultView = ConnectDefaultHeaderView()
        resultView.viewBlock = { [weak self] selected in
            if selected == .address {
                let viewController = AddressDetailViewController()
                self?.navigationController?.pushViewController(viewController, animated: true)
            } else if selected == .speed {
                let viewController = ProductWebViewController()
                self?.navigationController?.pushViewController(viewController, animated: true)
            } else {
                let viewController = ProductSubscriptonViewController()
                viewController.modalPresentationStyle = .fullScreen
                viewController.modalTransitionStyle = .coverVertical
                self?.present(viewController, animated: true)
            }
        }
        return resultView
    }()
    
    lazy var vipHeaderView: ConnectVIPHeaderView = {
        let resultView = ConnectVIPHeaderView()
        resultView.viewBlock = { [weak self] selected in
            if selected == .address {
                let viewController = AddressDetailViewController()
                self?.navigationController?.pushViewController(viewController, animated: true)
            } else if selected == .speed {
                let viewController = AddressDetailViewController()
                self?.navigationController?.pushViewController(viewController, animated: true)
            }
        }
        resultView.isHidden = true
        return resultView
    }()
    
    lazy var noConnoctAnimationView: ConnectNoConnoctAnimationView = {
        let resultView = ConnectNoConnoctAnimationView()
        resultView.viewBlock = { [weak self] in
            self?.connect()
        }
        return resultView
    }()
    
    lazy var connoctedAnimationView: ConnectConnoctedAnimationView = {
        let resultView = ConnectConnoctedAnimationView()
        resultView.isHidden = true
        resultView.viewBlock = { [weak self] in
            self?.connect()
        }
        return resultView
    }()
    
    lazy var titleLabel_0: UILabel = {
        let resultView = UILabel()
        resultView.text = RequestManager.shared.currentSelectedRegionItem.regionCountry
        resultView.font = UIFont.fitFont(.bold, 30)
        resultView.textColor = UIColor(red: 138/255, green: 255/255, blue: 232/255, alpha: 1)
        resultView.sizeToFit()
        return resultView
    }()
    
    lazy var titleLabel_1: UILabel = {
        let resultView = UILabel()
        resultView.text = RequestManager.shared.currentSelectedRegionItem.regionCity
        resultView.font = UIFont.fitFont(.regular, 14)
        resultView.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
        resultView.sizeToFit()
        return resultView
    }()
    
    lazy var timeLabel: UILabel = {
        let resultView = UILabel()
        resultView.font = UIFont.fitFont(.medium, 14)
        resultView.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
        return resultView
    }()
 
    lazy var timeView: ConnectTimeConfigView = {
        let resultView = ConnectTimeConfigView()
        resultView.view_60_Block = { [weak self] in
            NetworkManager.shared.addFreeTime(times: 60)
        }
        resultView.view_120_Block = { [weak self] in
            NetworkManager.shared.addFreeTime(times: 120)
        }
        return resultView
    }()
}


extension ConnectViewController {
    
    /// 开始连接
    func connect() {
        if timer != nil {
            return
        }
        if RequestManager.shared.currentRegionItem.regionLimit {
            // 限制地区，强制退出
            self.showButtonAlert_1(title: "App Not Available", message: "This app is currently not available in your country or region.", buttonTitle: "OK") {
//                abort()
            }
            return
        }
        if NetworkManager.shared.status == .connecting {
            return
        } else if NetworkManager.shared.status == .connected {
            self.pushCancel()
        } else {
            self.showAnimationAlert(title: "Connecting...", buttonAction: {
                
            })
            NetworkManager.shared.configure(withIP: RequestManager.shared.currentSelectedRegionItem.regionIP ?? "", port: RequestManager.shared.currentSelectedRegionItem.regionPortItems[0]) {[weak self] config in
                if config {
                    // 授权成功，开始连接
                    self?.addressCount = 0
                    self?.flowTimeCount = 0
                    self?.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] _ in
                        print("开始连接..... " + "addressCount = \(self?.addressCount ?? 0) " + "flowTimeCount = \(self?.flowTimeCount ?? 0) " + "allCount = \(RequestManager.shared.currentSelectedRegionItem.regionPortItems.count) ")
                        if self?.flowTimeCount == 0 {
                            self?.flowTimeCount += 1
                            if self?.addressCount ?? 0 < RequestManager.shared.currentSelectedRegionItem.regionPortItems.count {
                                print("正在连接..... " + "ip = \(String(describing: RequestManager.shared.currentSelectedRegionItem.regionIP)) " + "flowTimeCount = \(RequestManager.shared.currentSelectedRegionItem.regionPortItems[self?.addressCount ?? 0]) ")
                                RequestManager.shared.currentSelectedRegionItem.regionConnectTime = CLongLong(RequestManager.nowTime(true))
                                NetworkManager.shared.start(withIP: RequestManager.shared.currentSelectedRegionItem.regionIP ?? "", port: RequestManager.shared.currentSelectedRegionItem.regionPortItems[self?.addressCount ?? 0]) {[weak self] success in
                                    if success {
                                        self?.timer?.invalidate()
                                        self?.timer = nil
                                        print("连接成功.....")
                                        self?.pushSuccess()
                                    }
                                }
                                print("连接中..... " + "ip = \(RequestManager.shared.currentSelectedRegionItem.regionIP ?? "") " + "flowTimeCount = \(RequestManager.shared.currentSelectedRegionItem.regionPortItems[self?.addressCount ?? 0]) ")
                            } else {
                                self?.timer?.invalidate()
                                self?.timer = nil
                                print("全部端口尝试连接完，停止连接.....")
                                self?.pushFail()
                            }
                        } else {
                            DispatchQueue.main.async { [weak self] in
                                self?.flowTimeCount += 1
                                if self?.flowTimeCount ?? 0 > RequestManager.shared.currentSelectedRegionItem.regionTimeout / 1000 {
                                    self?.flowTimeCount = 0
                                    self?.addressCount += 1
                                }
                            }
                        }
                    })
                } else {
                    // 授权失败， 跳转结果页
                    self?.pushFail()
                }
            }
        }
    }
}



extension ConnectViewController {
    
    // 免费使用时间的通知
    @objc func handleFreeTimeNotification() {
        DispatchQueue.main.async { [weak self] in
            if NetworkManager.shared.status == .connected {
                self?.timeLabel.text = NetworkManager.shared.formatTime()
                self?.timeLabel.sizeToFit()
            } else {
                self?.timeLabel.text = "--"
                self?.timeLabel.sizeToFit()
            }
        }
    }

}



extension ConnectViewController {
    
    func pushSuccess() {
        HistoryManager.shared.addItem(regionItem: RequestManager.shared.currentSelectedRegionItem)
        DispatchQueue.main.async { [weak self] in
            self?.dismissAlert()
            let viewController = SuccessViewController()
            self?.navigationController?.pushViewController(viewController, animated: false)
        }
    }
    
    func pushFail() {
        HistoryManager.shared.addItem(regionItem: RequestManager.shared.currentSelectedRegionItem)
        DispatchQueue.main.async { [weak self] in
            self?.dismissAlert()
            let viewController = FailtureViewController()
            self?.navigationController?.pushViewController(viewController, animated: false)
        }
    }
    
    func pushCancel() {
        DispatchQueue.main.async { [weak self] in
            self?.dismissAlert()
            let viewController = BreakOffViewController()
            self?.navigationController?.pushViewController(viewController, animated: false)
        }
    }
}



extension ConnectViewController {
    
    /// 前台定时器：每秒执行一次
    func firstStartTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(firstExecuteTask), userInfo: nil, repeats: true)
    }
    
    @objc func firstExecuteTask() {
        self.timerNumber += 1
        if self.timerNumber >= 3 {
            timer?.invalidate()
            timer = nil
            self.timerNumber = 0
            self.dismissAlert()
            NetworkManager.shared.addFreeTime(times: 60)
            self.showAddTimeAlert { [weak self] in
                self?.showAnimationAlert(title: "Waiting...") {
                    
                }
                self?.secoundStartTimer()
            }
        }
    }
}


extension ConnectViewController {
    
    /// 前台定时器：每秒执行一次
    func secoundStartTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(secoundExecuteTask), userInfo: nil, repeats: true)
    }
    
    @objc func secoundExecuteTask() {
        self.timerNumber += 1
        if self.timerNumber >= 3 {
            timer?.invalidate()
            timer = nil
            self.timerNumber = 0
            self.dismissAlert()
            NetworkManager.shared.addFreeTime(times: 120)
            self.showTimeStatusAlert {
            }
        }
    }
}
