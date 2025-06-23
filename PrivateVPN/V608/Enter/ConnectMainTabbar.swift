//
//  ConnectMainTabbar.swift
//  V608
//
//  Created by Thomas on 2024/9/9.
//

import UIKit

enum ConnectMainType: String {
    case home = "home"
    case address = "address"
    case setting = "setting"
}

typealias TabViewBlock = (ConnectMainType) -> (Void)

class ConnectMainTabbar: UIView {

    var viewBlock: TabViewBlock?
    
    var connnectType: ConnectMainType = ConnectMainType.home
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backView)
        addSubview(animationView)
        addSubview(buttonView_0)
        addSubview(buttonView_1)
        addSubview(buttonView_2)
        addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backView.frameCenterX = self.frameWidth / 2
        backView.frameCenterY = self.frameHeight / 2
        animationView.frameCenterY = self.frameHeight / 2
        buttonView_0.frameCenterY = self.frameHeight / 2
        buttonView_1.frameCenterY = self.frameHeight / 2
        buttonView_2.frameCenterY = self.frameHeight / 2
        titleLabel.frameCenterY = self.frameHeight / 2
        if connnectType == .home {
            animationView.frameLeft = fitViewHeight(10)
            buttonView_0.frameLeft = animationView.frameLeft + fitViewHeight(15)
            titleLabel.frameRight = animationView.frameRight - fitViewHeight(15)
            buttonView_1.frameLeft = animationView.frameRight + fitViewHeight(30)
            buttonView_2.frameLeft = buttonView_1.frameRight + fitViewHeight(30)
        } else if connnectType == .address {
            animationView.frameCenterX = self.frameWidth / 2
            buttonView_0.frameRight = animationView.frameLeft - fitViewHeight(30)
            buttonView_2.frameLeft = animationView.frameRight + fitViewHeight(30)
            buttonView_1.frameLeft = animationView.frameLeft + fitViewHeight(15)
            titleLabel.frameRight = animationView.frameRight - fitViewHeight(15)
        } else {
            animationView.frameRight = self.frameWidth - fitViewHeight(10)
            buttonView_1.frameRight = animationView.frameLeft - fitViewHeight(30)
            buttonView_0.frameRight = buttonView_1.frameLeft - fitViewHeight(30)
            titleLabel.frameRight = animationView.frameRight - fitViewHeight(15)
            buttonView_2.frameLeft = animationView.frameLeft + fitViewHeight(15)
        }
    }
    
    func updateStatus(status: ConnectMainType) {
        if status == connnectType {
            return
        }
        connnectType = status
        if connnectType == .home {
            buttonView_0.setImage(UIImage(named: "view_selected_0_icon"), for: .normal)
            buttonView_1.setImage(UIImage(named: "view_default_1_icon"), for: .normal)
            buttonView_2.setImage(UIImage(named: "view_default_2_icon"), for: .normal)
            titleLabel.text = "Home"
            titleLabel.sizeToFit()
        } else if connnectType == .address {
            buttonView_0.setImage(UIImage(named: "view_default_0_icon"), for: .normal)
            buttonView_1.setImage(UIImage(named: "view_selected_1_icon"), for: .normal)
            buttonView_2.setImage(UIImage(named: "view_default_2_icon"), for: .normal)
            titleLabel.text = "Address"
            titleLabel.sizeToFit()
        } else {
            buttonView_0.setImage(UIImage(named: "view_default_0_icon"), for: .normal)
            buttonView_1.setImage(UIImage(named: "view_default_1_icon"), for: .normal)
            buttonView_2.setImage(UIImage(named: "view_selected_2_icon"), for: .normal)
            titleLabel.text = "Setting"
            titleLabel.sizeToFit()
        }
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    lazy var backView: UIView = {
        let resultView = UIView()
        resultView.frameSize = CGSize(width: fitViewHeight(269), height: fitViewHeight(62))
        // strokeCode
        let borderLayer1 = CALayer()
        borderLayer1.frame = resultView.bounds
        borderLayer1.backgroundColor = UIColor(red: 0.54, green: 1, blue: 0.91, alpha: 0.3).cgColor
        resultView.layer.addSublayer(borderLayer1)
        // shadowCode
        resultView.layer.shadowColor = UIColor(red: 0.06, green: 0.06, blue: 0.06, alpha: 1).cgColor
        resultView.layer.shadowOffset = CGSize(width: 0, height: 4)
        resultView.layer.cornerRadius = fitViewHeight(31)
        resultView.layer.masksToBounds = true
        return resultView
    }()
        
    lazy var animationView: UIView = {
        let resultView = UIView()
        resultView.frameSize = CGSize(width: fitViewHeight(114), height: fitViewHeight(56))
        resultView.backgroundColor = UIColor(red: 49/255, green: 62/255, blue: 58/255, alpha: 1)
        resultView.layer.shadowOffset = CGSize(width: 0, height: 4)
        resultView.layer.cornerRadius = fitViewHeight(28)
        resultView.layer.masksToBounds = true
        return resultView
    }()
    
    lazy var buttonView_0: UIButton = {
        let resultView = UIButton(type: .custom)
        resultView.setImage(UIImage(named: "view_selected_0_icon"), for: .normal)
        resultView.frameSize = CGSize(width: fitViewHeight(24), height: fitViewHeight(24))
        resultView.addTarget(self, action: #selector(buttonDidClick_0), for: .touchUpInside)
        return resultView
    }()

    lazy var buttonView_1: UIButton = {
        let resultView = UIButton(type: .custom)
        resultView.setImage(UIImage(named: "view_default_1_icon"), for: .normal)
        resultView.frameSize = CGSize(width: fitViewHeight(24), height: fitViewHeight(24))
        resultView.addTarget(self, action: #selector(buttonDidClick_1), for: .touchUpInside)
        return resultView
    }()

    lazy var buttonView_2: UIButton = {
        let resultView = UIButton(type: .custom)
        resultView.setImage(UIImage(named: "view_default_2_icon"), for: .normal)
        resultView.frameSize = CGSize(width: fitViewHeight(24), height: fitViewHeight(24))
        resultView.addTarget(self, action: #selector(buttonDidClick_2), for: .touchUpInside)
        return resultView
    }()
    
    lazy var titleLabel: UILabel = {
        let resultView = UILabel()
        resultView.text = "Home"
        resultView.font = UIFont.fitFont(.medium, 14)
        resultView.textColor = UIColor(red: 138/255, green: 255/255, blue: 232/255, alpha: 1)
        resultView.sizeToFit()
        return resultView
    }()
    
}

extension ConnectMainTabbar {
    
    @objc func buttonDidClick_0(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.updateStatus(status: .home)
            if self?.viewBlock != nil {
                self?.viewBlock?(.home)
            }
        }
    }
    
    @objc func buttonDidClick_1(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.updateStatus(status: .address)
            if self?.viewBlock != nil {
                self?.viewBlock?(.address)
            }
        }
    }
    
    @objc func buttonDidClick_2(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.updateStatus(status: .setting)
            if self?.viewBlock != nil {
                self?.viewBlock?(.setting)
            }
        }
    }
}
