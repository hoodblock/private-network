//
//  BreakOffViewController.swift
//  V608
//
//  Created by Thomas on 2024/9/6.
//

import UIKit


// 连接成功页面

class BreakOffViewController : UIViewController {
    
    private var timer: Timer?
    private var timerNumber: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.addSubview(headerView)
        view.addSubview(topImageView)
        view.addSubview(titleLabel)
        view.addSubview(timeView)
        timerNumber = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
      
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        headerView.frameSize = CGSize(width: view.frameWidth, height: fitViewHeight(50))
        headerView.frameTop = self.view.safeAreaInsets.top
        topImageView.frameSize = CGSize(width: fitViewHeight(170), height: fitViewHeight(170))
        topImageView.frameCenterX = view.frameWidth / 2
        topImageView.frameTop = headerView.frameBottom + fitViewHeight(30)
        titleLabel.frameCenterX = view.frameWidth / 2
        titleLabel.frameTop = topImageView.frameBottom + fitViewHeight(10)
        timeView.frameSize = CGSize(width: view.frameWidth, height: view.frameWidth * 66 / 171)
        timeView.frameTop = titleLabel.frameBottom + fitViewHeight(30)
    }
    
    lazy var topImageView: UIImageView = {
        let resultView = UIImageView()
        resultView.image = UIImage(named: "connect_success_icon")
        return resultView
    }()
    
    lazy var titleLabel: UILabel = {
        let resultView = UILabel()
        resultView.text = "Cancel Connection"
        resultView.font = UIFont.fitFont(.semiBold, 18)
        resultView.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        resultView.sizeToFit()
        return resultView
    }()
    
    lazy var headerView: TopHeaderView = {
        let resultView = TopHeaderView()
        resultView.updateTitle(title: "Connect")
        resultView.viewBlock = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        return resultView
    }()
    
    lazy var timeView: ConnectTimeConfigView = {
        let resultView = ConnectTimeConfigView()
        resultView.view_60_Block = { [weak self] in
            // 加载一下加时间的弹窗呢， 然后做动画，延长5秒，
            self?.showAnimationAlert(title: "Waiting...") {
                
            }
            self?.firstStartTimer()
        }
        resultView.view_120_Block = { [weak self] in
            // 这里是否要加载一下加时间的弹窗呢， 然后做动画，然后消失
            self?.showAnimationAlert(title: "Waiting...") {
                
            }
            self?.secoundStartTimer()
        }
        return resultView
    }()
}

extension BreakOffViewController {
    
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


extension BreakOffViewController {
    
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
