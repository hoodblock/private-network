//
//  MemberShipViewController.swift
//  PrivateNetwork
//
//  Created by Thomas on 2024/9/6.
//

import UIKit

// 我的订阅详情页面


// MARK: - 顶部版本

class MemberHeaderView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addSubview(titleLabel_1)
        addSubview(titleLabel_2)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frameLeft = fitViewHeight(20)
        imageView.frameBottom = self.frameHeight
        titleLabel_1.frameLeft = imageView.frameRight + fitViewHeight(12)
        titleLabel_2.frameLeft = imageView.frameRight + fitViewHeight(12)
        titleLabel_1.frameTop = imageView.frameTop
        titleLabel_2.frameBottom = imageView.frameBottom
    }
    
    lazy var imageView: UIImageView = {
        let resultView = UIImageView()
        resultView.image = UIImage(named: "setting_header_app_icon")
        resultView.frameSize = CGSize(width: fitViewHeight(50), height: fitViewHeight(50))
        resultView.layer.cornerRadius = fitViewHeight(10)
        resultView.layer.masksToBounds = true
        return resultView
    }()
    
    lazy var titleLabel_1: UILabel = {
        let resultView = UILabel()
        resultView.text = "Private Network"
        resultView.font = UIFont.fitFont(.bold, 18)
        resultView.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        resultView.sizeToFit()
        return resultView
    }()
    
    lazy var titleLabel_2: UILabel = {
        let resultView = UILabel()
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            resultView.text = "Version: " + version
        } else {
            resultView.text = "Version: " + "1.0.0"
        }
        resultView.font = UIFont.fitFont(.regular, 12)
        resultView.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.7)
        resultView.sizeToFit()
        return resultView
    }()
}

// MARK: - 中间未支付模型

class MemberNoPayView: UIView {
    
    var viewBlock: ViewBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel_0)
        addSubview(backImageView)
        addSubview(vipImageView)
        addSubview(titleLabel_1)
        addSubview(titleLabel_2)
        addSubview(bottomButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel_0.frameLeft = fitViewHeight(20)
        backImageView.frameLeft = fitViewHeight(20)
        titleLabel_0.frameTop = fitViewHeight(10)
        backImageView.frameTop = titleLabel_0.frameBottom + fitViewHeight(10)
        backImageView.frameHeight = self.frameHeight - backImageView.frameTop
        backImageView.frameWidth = frameWidth - fitViewHeight(20) * 2
        titleLabel_2.heightAuthSize(fitViewHeight(backImageView.frameWidth - 40 * 2))
        vipImageView.frameCenterX = backImageView.frameCenterX
        vipImageView.frameTop = backImageView.frameTop + fitViewHeight(20)
        titleLabel_1.frameCenterX = backImageView.frameCenterX
        titleLabel_1.frameTop = vipImageView.frameBottom + fitViewHeight(10)
        titleLabel_2.frameCenterX = backImageView.frameCenterX
        titleLabel_2.frameTop = titleLabel_1.frameBottom + fitViewHeight(10)
        bottomButton.frameSize = CGSize(width: backImageView.frameWidth - fitViewHeight(50 * 2), height: fitViewHeight(40))
        bottomButton.frameCenterX = backImageView.frameCenterX
        bottomButton.frameBottom = backImageView.frameBottom - fitViewHeight(20)
    }
    
    lazy var backImageView: UIImageView = {
        let resultView = UIImageView()
        resultView.image = UIImage(named: "vip_grade_max_background_icon")
        return resultView
    }()
    
    lazy var titleLabel_0: UILabel = {
        let resultView = UILabel()
        resultView.text = "Subscription"
        resultView.font = UIFont.fitFont(.medium, 14)
        resultView.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.7)
        resultView.sizeToFit()
        return resultView
    }()
    
    lazy var vipImageView: UIImageView = {
        let resultView = UIImageView()
        resultView.image = UIImage(named: "vip_glob_icon")
        resultView.frameSize = CGSize(width: fitViewHeight(32), height: fitViewHeight(32))
        return resultView
    }()
 
    lazy var titleLabel_1: UILabel = {
        let resultView = UILabel()
        resultView.text = "VIP Membership"
        resultView.font = UIFont.fitFont(.semiBold, 16)
        resultView.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        resultView.sizeToFit()
        return resultView
    }()
    
    lazy var titleLabel_2: UILabel = {
        let resultView = UILabel()
        resultView.text = "Activate VIP membership and enjoy exclusive perks!"
        resultView.font = UIFont.fitFont(.regular, 12)
        resultView.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.8)
        resultView.numberOfLines = 0
        resultView.textAlignment = .center
        return resultView
    }()
    
    lazy var bottomButton: ImageTitleButton = {
        let resultView = ImageTitleButton()
        resultView.createTitleImageButton(title: "Get all privileges", titleColor: UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1), titleFont: UIFont.fitFont(.bold, 14), imageName: "to_right_white_icon", imageSize: CGSize(width: UIView.fitViewHeight(20), height: UIView.fitViewHeight(10)), cornerRadius: UIView.fitViewHeight(20), backgroundColor: UIColor(red: 16/255, green: 16/255, blue: 16/255, alpha: 1))
        resultView.viewBlock = { [weak self] in
            if self?.viewBlock != nil {
                self?.viewBlock!()
            }
        }
        return resultView
    }()
}

// MARK: - 中间已支付模型

class MembePaiedView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel_0)
        addSubview(backImageView)
        addSubview(vipImageView)
        addSubview(titleLabel_1)
        addSubview(titleLabel_2)
        addSubview(iconTitleLabel_0)
        addSubview(iconTitleLabel_1)
        addSubview(iconTitleLabel_2)
        addSubview(iconImageView_0)
        addSubview(iconImageView_1)
        addSubview(iconImageView_2)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel_0.frameLeft = fitViewHeight(20)
        backImageView.frameLeft = fitViewHeight(20)
        titleLabel_0.frameTop = fitViewHeight(10)
        backImageView.frameTop = titleLabel_0.frameBottom + fitViewHeight(10)
        backImageView.frameHeight = self.frameHeight - backImageView.frameTop
        backImageView.frameWidth = frameWidth - fitViewHeight(20) * 2
        vipImageView.frameCenterX = backImageView.frameCenterX
        vipImageView.frameTop = backImageView.frameTop + fitViewHeight(20)
        titleLabel_1.frameCenterX = backImageView.frameCenterX
        titleLabel_1.frameTop = vipImageView.frameBottom + fitViewHeight(10)
        titleLabel_2.frameCenterX = backImageView.frameCenterX
        titleLabel_2.frameTop = titleLabel_1.frameBottom + fitViewHeight(10)
        iconTitleLabel_1.frameBottom = backImageView.frameBottom - fitViewHeight(20)
        iconImageView_1.frameBottom = iconTitleLabel_1.frameTop - fitViewHeight(10)
        iconTitleLabel_0.frameBottom = backImageView.frameBottom - fitViewHeight(20)
        iconImageView_0.frameBottom = iconTitleLabel_0.frameTop - fitViewHeight(10)
        iconTitleLabel_2.frameBottom = backImageView.frameBottom - fitViewHeight(20)
        iconImageView_2.frameBottom = iconTitleLabel_2.frameTop - fitViewHeight(10)
        iconImageView_1.frameCenterX = backImageView.frameCenterX
        iconImageView_0.frameRight = iconImageView_1.frameLeft - fitViewHeight(70)
        iconImageView_2.frameLeft = iconImageView_1.frameRight + fitViewHeight(70)
        iconTitleLabel_1.frameCenterX = iconImageView_1.frameCenterX
        iconTitleLabel_0.frameCenterX = iconImageView_0.frameCenterX
        iconTitleLabel_2.frameCenterX = iconImageView_2.frameCenterX
    }
    
    lazy var backImageView: UIImageView = {
        let resultView = UIImageView()
        resultView.image = UIImage(named: "vip_grade_max_background_icon")
        return resultView
    }()
    
    lazy var titleLabel_0: UILabel = {
        let resultView = UILabel()
        resultView.text = "Subscription"
        resultView.font = UIFont.fitFont(.medium, 14)
        resultView.textColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.7)
        resultView.sizeToFit()
        return resultView
    }()
    
    lazy var vipImageView: UIImageView = {
        let resultView = UIImageView()
        resultView.image = UIImage(named: "vip_glob_icon")
        resultView.frameSize = CGSize(width: fitViewHeight(32), height: fitViewHeight(32))
        return resultView
    }()
 
    lazy var titleLabel_1: UILabel = {
        let resultView = UILabel()
        resultView.text = "VIP Membership"
        resultView.font = UIFont.fitFont(.semiBold, 16)
        resultView.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        resultView.sizeToFit()
        return resultView
    }()
    
    lazy var titleLabel_2: UILabel = {
        let resultView = UILabel()
        resultView.text = "Expires on 2025.01.29"
        resultView.font = UIFont.fitFont(.regular, 12)
        resultView.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.8)
        resultView.sizeToFit()
        return resultView
    }()
    
    
    lazy var iconImageView_0: UIImageView = {
        let resultView = UIImageView()
        resultView.image = UIImage(named: "vip_remove_ad_selected_icon")
        resultView.frameSize = CGSize(width: fitViewHeight(40), height: fitViewHeight(40))
        return resultView
    }()
    
    lazy var iconTitleLabel_0: UILabel = {
        let resultView = UILabel()
        resultView.text = "Remove Ads"
        resultView.font = UIFont.fitFont(.regular, 12)
        resultView.textColor = UIColor(red: 57/255, green: 54/255, blue: 114/255, alpha: 1)
        resultView.sizeToFit()
        return resultView
    }()
    
    lazy var iconImageView_1: UIImageView = {
        let resultView = UIImageView()
        resultView.image = UIImage(named: "vip_good_address_selected_icon")
        resultView.frameSize = CGSize(width: fitViewHeight(40), height: fitViewHeight(40))
        return resultView
    }()
    
    lazy var iconTitleLabel_1: UILabel = {
        let resultView = UILabel()
        resultView.text = "Premium Servers"
        resultView.font = UIFont.fitFont(.regular, 12)
        resultView.textColor = UIColor(red: 57/255, green: 54/255, blue: 114/255, alpha: 1)
        resultView.sizeToFit()
        return resultView
    }()
    
    lazy var iconImageView_2: UIImageView = {
        let resultView = UIImageView()
        resultView.image = UIImage(named: "vip_detail_local_selected_icon")
        resultView.frameSize = CGSize(width: fitViewHeight(40), height: fitViewHeight(40))
        return resultView
    }()
    
    lazy var iconTitleLabel_2: UILabel = {
        let resultView = UILabel()
        resultView.text = "Top Regions"
        resultView.font = UIFont.fitFont(.regular, 12)
        resultView.textColor = UIColor(red: 57/255, green: 54/255, blue: 114/255, alpha: 1)
        resultView.sizeToFit()
        return resultView
    }()
}

// MARK: - 评价

class MembeRateView: UIView {
    
    var viewBlock: ViewBlock?

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel_0)
        addSubview(backImageView)
        addSubview(vipImageView)
        addSubview(titleLabel_1)
        addSubview(titleLabel_2)
        addSubview(iconImageView_0)
        addSubview(iconImageView_1)
        addSubview(iconImageView_2)
        addSubview(iconImageView_3)
        addSubview(iconImageView_4)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel_0.frameLeft = fitViewHeight(20)
        backImageView.frameLeft = fitViewHeight(20)
        titleLabel_0.frameTop = fitViewHeight(10)
        backImageView.frameTop = titleLabel_0.frameBottom + fitViewHeight(10)
        backImageView.frameHeight = self.frameHeight - backImageView.frameTop
        backImageView.frameWidth = frameWidth - fitViewHeight(20) * 2
        vipImageView.frameCenterX = backImageView.frameCenterX
        vipImageView.frameTop = backImageView.frameTop + fitViewHeight(20)
        titleLabel_1.frameCenterX = backImageView.frameCenterX
        titleLabel_1.frameTop = vipImageView.frameBottom + fitViewHeight(10)
        titleLabel_2.frameCenterX = backImageView.frameCenterX
        titleLabel_2.frameTop = titleLabel_1.frameBottom + fitViewHeight(10)
        iconImageView_0.frameBottom = backImageView.frameBottom - fitViewHeight(20)
        iconImageView_1.frameBottom = backImageView.frameBottom - fitViewHeight(20)
        iconImageView_2.frameBottom = backImageView.frameBottom - fitViewHeight(20)
        iconImageView_3.frameBottom = backImageView.frameBottom - fitViewHeight(20)
        iconImageView_4.frameBottom = backImageView.frameBottom - fitViewHeight(20)
        iconImageView_2.frameCenterX = backImageView.frameCenterX
        iconImageView_1.frameRight = iconImageView_2.frameLeft - fitViewHeight(20)
        iconImageView_0.frameRight = iconImageView_1.frameLeft - fitViewHeight(20)
        iconImageView_3.frameLeft = iconImageView_2.frameRight + fitViewHeight(20)
        iconImageView_4.frameLeft = iconImageView_3.frameRight + fitViewHeight(20)
    }
    
    lazy var backImageView: UIImageView = {
        let resultView = UIImageView()
        resultView.backgroundColor = UIColor(red: 138/255, green: 255/255, blue: 232/255, alpha: 0.3)
        resultView.layer.cornerRadius = fitViewHeight(15)
        resultView.layer.masksToBounds = true
        return resultView
    }()
    
    lazy var titleLabel_0: UILabel = {
        let resultView = UILabel()
        resultView.text = "Evaluate"
        resultView.font = UIFont.fitFont(.medium, 14)
        resultView.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.7)
        resultView.sizeToFit()
        return resultView
    }()
    
    lazy var vipImageView: UIImageView = {
        let resultView = UIImageView()
        resultView.image = UIImage(named: "feedback_icon")
        resultView.frameSize = CGSize(width: fitViewHeight(32), height: fitViewHeight(32))
        return resultView
    }()
 
    lazy var titleLabel_1: UILabel = {
        let resultView = UILabel()
        resultView.text = "Your feedback matters"
        resultView.font = UIFont.fitFont(.semiBold, 16)
        resultView.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        resultView.sizeToFit()
        return resultView
    }()
    
    lazy var titleLabel_2: UILabel = {
        let resultView = UILabel()
        resultView.text = "Let us know how we're doing!"
        resultView.font = UIFont.fitFont(.regular, 12)
        resultView.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.8)
        resultView.sizeToFit()
        return resultView
    }()
    
    lazy var iconImageView_0: UIButton = {
        let resultView = UIButton(type: .custom)
        resultView.setImage(UIImage(named: "feedback_default_icon"), for: .normal)
        resultView.setImage(UIImage(named: "feedback_select_icon"), for: .highlighted)
        resultView.frameSize = CGSize(width: fitViewHeight(40), height: fitViewHeight(40))
        resultView.addTarget(self, action: #selector(buttonDidClick), for: .touchUpInside)
        return resultView
    }()
    
    lazy var iconImageView_1: UIButton = {
        let resultView = UIButton(type: .custom)
        resultView.setImage(UIImage(named: "feedback_default_icon"), for: .normal)
        resultView.setImage(UIImage(named: "feedback_select_icon"), for: .highlighted)
        resultView.frameSize = CGSize(width: fitViewHeight(40), height: fitViewHeight(40))
        resultView.addTarget(self, action: #selector(buttonDidClick), for: .touchUpInside)
        return resultView
    }()
    
    lazy var iconImageView_2: UIButton = {
        let resultView = UIButton(type: .custom)
        resultView.setImage(UIImage(named: "feedback_default_icon"), for: .normal)
        resultView.setImage(UIImage(named: "feedback_select_icon"), for: .highlighted)
        resultView.frameSize = CGSize(width: fitViewHeight(40), height: fitViewHeight(40))
        resultView.addTarget(self, action: #selector(buttonDidClick), for: .touchUpInside)
        return resultView
    }()
    
    lazy var iconImageView_3: UIButton = {
        let resultView = UIButton(type: .custom)
        resultView.setImage(UIImage(named: "feedback_default_icon"), for: .normal)
        resultView.setImage(UIImage(named: "feedback_select_icon"), for: .highlighted)
        resultView.frameSize = CGSize(width: fitViewHeight(40), height: fitViewHeight(40))
        resultView.addTarget(self, action: #selector(buttonDidClick), for: .touchUpInside)
        return resultView
    }()
    
    lazy var iconImageView_4: UIButton = {
        let resultView = UIButton(type: .custom)
        resultView.setImage(UIImage(named: "feedback_default_icon"), for: .normal)
        resultView.setImage(UIImage(named: "feedback_select_icon"), for: .highlighted)
        resultView.frameSize = CGSize(width: fitViewHeight(40), height: fitViewHeight(40))
        resultView.addTarget(self, action: #selector(buttonDidClick), for: .touchUpInside)
        return resultView
    }()
    
    @objc func buttonDidClick(_ sender: UIButton) {
        if viewBlock != nil {
            viewBlock!()
        }
    }
}

// MARK: - telegram 入口

class MembeTelegramView: UIView {
    
    var viewBlock: ViewBlock?

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel_0)
        addSubview(backImageView)
        addSubview(vipImageView)
        addSubview(titleLabel_1)
        addSubview(iconImageView_0)
        addSubview(backButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel_0.frameLeft = fitViewHeight(20)
        backImageView.frameLeft = fitViewHeight(20)
        titleLabel_0.frameTop = fitViewHeight(10)
        backImageView.frameTop = titleLabel_0.frameBottom + fitViewHeight(10)
        backImageView.frameHeight = self.frameHeight - backImageView.frameTop
        backImageView.frameWidth = frameWidth - fitViewHeight(20) * 2
        vipImageView.frameCenterY = backImageView.frameCenterY
        titleLabel_1.frameCenterY = backImageView.frameCenterY
        iconImageView_0.frameCenterY = backImageView.frameCenterY
        vipImageView.frameLeft = backImageView.frameLeft + fitViewHeight(20)
        titleLabel_1.frameLeft = vipImageView.frameRight + fitViewHeight(10)
        iconImageView_0.frameRight = backImageView.frameRight - fitViewHeight(20)
        backButton.frameSize = backImageView.frameSize
        backButton.frameCenterY = backImageView.frameCenterY
        backButton.frameCenterX = backImageView.frameCenterX
    }
    
    lazy var backImageView: UIImageView = {
        let resultView = UIImageView()
        resultView.backgroundColor = UIColor(red: 138/255, green: 255/255, blue: 232/255, alpha: 0.3)
        resultView.layer.cornerRadius = fitViewHeight(15)
        resultView.layer.masksToBounds = true
        return resultView
    }()
    
    lazy var titleLabel_0: UILabel = {
        let resultView = UILabel()
        resultView.text = "Telegram"
        resultView.font = UIFont.fitFont(.medium, 14)
        resultView.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.7)
        resultView.sizeToFit()
        return resultView
    }()
    
    lazy var vipImageView: UIImageView = {
        let resultView = UIImageView()
        resultView.image = UIImage(named: "feedback_group_icon")
        resultView.frameSize = CGSize(width: fitViewHeight(32), height: fitViewHeight(32))
        return resultView
    }()
 
    lazy var titleLabel_1: UILabel = {
        let resultView = UILabel()
        resultView.text = "Join Telegram Now"
        resultView.font = UIFont.fitFont(.semiBold, 16)
        resultView.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        resultView.sizeToFit()
        return resultView
    }()
    
    lazy var backButton: UIButton = {
        let resultView = UIButton(type: .custom)
        resultView.addTarget(self, action: #selector(buttonDidClick), for: .touchUpInside)
        return resultView
    }()
    
    lazy var iconImageView_0: UIImageView = {
        let resultView = UIImageView()
        resultView.image = UIImage(named: "to_right_white_icon")
        resultView.frameSize = CGSize(width: fitViewHeight(20), height: fitViewHeight(10))
        return resultView
    }()
    
    @objc func buttonDidClick(_ sender: UIButton) {
        if viewBlock != nil {
            viewBlock!()
        }
    }
}


// MARK: - 主页面入口

class MemberShipViewController : UIViewController {
    
    var viewBlock: ViewBlock?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = UIColor(red: 16/255, green: 16/255, blue: 16/255, alpha: 1)
        view.addSubview(memberHeaderView)
//        view.addSubview(noPayView)
//        view.addSubview(paiedView)
        view.addSubview(rateView)
        view.addSubview(tegegramView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        if SubscriptionConfig.shared.isPaied() {
            noPayView.isHidden = true
            paiedView.isHidden = false
        } else {
            noPayView.isHidden = false
            paiedView.isHidden = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        memberHeaderView.frameSize = CGSize(width: view.frameWidth, height: fitViewHeight(50))
        memberHeaderView.frameTop = self.view.safeAreaInsets.top
//        noPayView.frameSize = CGSize(width: view.frameWidth, height: fitViewHeight(240))
//        paiedView.frameSize = CGSize(width: view.frameWidth, height: fitViewHeight(240))
//        noPayView.frameTop = memberHeaderView.frameBottom + fitViewHeight(15)
//        paiedView.frameTop = memberHeaderView.frameBottom + fitViewHeight(15)
        rateView.frameSize = CGSize(width: view.frameWidth, height: fitViewHeight(220))
        rateView.frameTop = memberHeaderView.frameBottom + fitViewHeight(15)
        tegegramView.frameSize = CGSize(width: view.frameWidth, height: fitViewHeight(100))
        tegegramView.frameTop = rateView.frameBottom + fitViewHeight(15)
    }
    
    lazy var memberHeaderView: MemberHeaderView = {
        let resultView = MemberHeaderView()
        return resultView
    }()
    
    lazy var noPayView: MemberNoPayView = {
        let resultView = MemberNoPayView()
        resultView.viewBlock = { [weak self] in
            let viewController = ProductSubscriptonViewController()
            viewController.modalPresentationStyle = .fullScreen
            viewController.modalTransitionStyle = .coverVertical
            self?.present(viewController, animated: true)
        }
        return resultView
    }()

    lazy var paiedView: MembePaiedView = {
        let resultView = MembePaiedView()
        return resultView
    }()
    
    lazy var rateView: MembeRateView = {
        let resultView = MembeRateView()
        resultView.viewBlock = { [weak self] in
//            if let url = URL(string: "itms-apps://apps.apple.com/app/id6473517249?action=write-review"), UIApplication.shared.canOpenURL(url) {
//                UIApplication.shared.open(url, options: [:], completionHandler: nil)
//            }
            if let url = URL(string: "itms-apps://apps.apple.com/app/"), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        return resultView
    }()

    lazy var tegegramView: MembeTelegramView = {
        let resultView = MembeTelegramView()
        resultView.viewBlock = { [weak self] in
            if let url = URL(string: "https://t.me/+GqhN-8e3fnMyMTI1"), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        return resultView
    }()
    
}
