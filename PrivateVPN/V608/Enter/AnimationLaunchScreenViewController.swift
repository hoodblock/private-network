//
//  AnimationLaunchScreenViewController.swift
//  V608
//
//  Created by Thomas on 2024/9/6.
//

import UIKit

let OPEN_ALL_TIME: CGFloat = 5.0
let OPEN_STEEP_TIME: CGFloat = 0.01

// 启动页，动画，广告
class AnimationLaunchScreenViewController : UIViewController {
    
    var viewBlock: ViewBlock?
    var animationStaticWidth: CGFloat = 0
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.addSubview(backImageView)
        view.addSubview(titleImageView)
        view.addSubview(titleLabel_0)
        view.addSubview(titleLabel_1)
        view.addSubview(titleLabel_2)
        view.addSubview(titleLabel_3)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateSpeed(OPEN_STEEP_TIME, animationStaticWidth / OPEN_ALL_TIME * OPEN_STEEP_TIME)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        backImageView.frame = CGRectMake(0, -10, view.frameWidth, view.frameHeight + 20)
        titleLabel_0.frameCenterY = view.frameHeight / 3 * 2
        titleLabel_0.frameCenterX = view.frameCenterX
        titleImageView.frameBottom = view.frameHeight - view.fitViewHeight(60)
        titleLabel_1.frameCenterY = titleImageView.frameCenterY
        titleLabel_2.frameCenterY = titleImageView.frameCenterY
        titleLabel_3.frameCenterY = titleImageView.frameCenterY
        titleImageView.frameLeft = view.frameWidth / 2 - (titleImageView.frameWidth + fitViewHeight(10) + titleLabel_3.frameWidth) / 2
        titleLabel_3.frameLeft = titleImageView.frameRight + fitViewHeight(10)
        titleLabel_1.frameLeft = titleImageView.frameRight + fitViewHeight(10)
        titleLabel_2.frameLeft = titleImageView.frameRight + fitViewHeight(10)
        titleLabel_1.frameHeight = titleLabel_3.frameHeight
        titleLabel_2.frameHeight = titleLabel_3.frameHeight
    }
    
    lazy var backImageView: UIImageView = {
        let resultView = UIImageView()
        resultView.image = UIImage(named: "launchScreen_icon")
        return resultView
    }()
    
    lazy var titleImageView: UIImageView = {
        let resultView = UIImageView()
        resultView.image = UIImage(named: "launch_bottom_animation_icon")
        resultView.frameSize = CGSize(width: fitViewHeight(20), height: fitViewHeight(20))
        return resultView
    }()
    
    lazy var titleLabel_0: UILabel = {
        let resultView = UILabel()
        resultView.text = "Private VPN"
        resultView.font = UIFont.fitFont(.bold, 28)
        resultView.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        resultView.sizeToFit()
        return resultView
    }()
    
    lazy var titleLabel_1: UILabel = {
        let resultView = UILabel()
        resultView.text = "PrivateVPN: Easy & Fast Proxy"
        resultView.font = UIFont.fitFont(.semiBold, 14)
        resultView.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
        resultView.textAlignment = .left
        resultView.lineBreakMode = .byClipping
        return resultView
    }()
    
    lazy var titleLabel_2: UILabel = {
        let resultView = UILabel()
        resultView.text = "PrivateVPN: Easy & Fast Proxy"
        resultView.font = UIFont.fitFont(.semiBold, 14)
        resultView.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        resultView.textAlignment = .left
        resultView.lineBreakMode = .byClipping
        return resultView
    }()
    
    lazy var titleLabel_3: UILabel = {
        let resultView = UILabel()
        resultView.text = "PrivateVPN: Easy & Fast Proxy"
        resultView.font = UIFont.fitFont(.semiBold, 14)
        resultView.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0)
        resultView.sizeToFit()
        animationStaticWidth = resultView.frameWidth
        return resultView
    }()
}

extension AnimationLaunchScreenViewController {
    
    func updateSpeed(_ times: TimeInterval, _ width: CGFloat) {
        timer = Timer.scheduledTimer(withTimeInterval: times, repeats: true, block: { _ in
            DispatchQueue.main.async { [weak self] in
                if (self?.animationStaticWidth)! - (self?.titleLabel_2.frameWidth)! <= 0 {
                    self?.openStart()
                    return
                }
                if (self?.titleLabel_2.frameWidth)! > (self?.animationStaticWidth)! {
                    self?.titleLabel_2.frameWidth = self?.animationStaticWidth ?? 0
                }
                if (self?.titleLabel_1.frameWidth)! > (self?.animationStaticWidth)! {
                    self?.titleLabel_1.frameWidth = self?.animationStaticWidth ?? 0
                } 
                if self?.titleLabel_1.frameWidth ?? 0 < self?.fitViewHeight(10) ?? 0 {
                    self?.titleLabel_1.frameWidth += width
                } else {
                    self?.titleLabel_1.frameWidth += width
                    self?.titleLabel_2.frameWidth += width
                }
            }
            self.viewWillLayoutSubviews()
        })
    }
    
    func openStart() {
        timer?.invalidate()
        timer = nil
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.toConnectView()
        }
    }
}
