//
//  AddressPressListSwitchView.swift
//  PrivateNetwork
//
//  Created by Thomas on 2024/9/19.
//

import UIKit

enum AddressPressListSwitchType: String {
    case free = "free"
    case vip = "vip"
    case collect = "collect"
}

typealias AddressPressViewBlock = (AddressPressListSwitchType) -> (Void)

class AddressPressListSwitchView: UIView {

    var viewBlock: AddressPressViewBlock?
    var switchType: AddressPressListSwitchType = AddressPressListSwitchType.free
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backView)
        addSubview(animationView)
        addSubview(buttonView_0)
//        addSubview(buttonView_1)
        addSubview(buttonView_2)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backView.frameSize = self.frameSize
        backView.frameCenterX = self.frameWidth / 2
        backView.frameCenterY = self.frameHeight / 2
        animationView.frameSize = CGSize(width: self.frameWidth / 2, height: self.frameHeight)
        animationView.frameCenterY = self.frameHeight / 2
        buttonView_0.frameSize = CGSize(width: self.frameWidth / 2, height: self.frameHeight)
//        buttonView_1.frameSize = CGSize(width: self.frameWidth / 3, height: self.frameHeight)
        buttonView_2.frameSize = CGSize(width: self.frameWidth / 2, height: self.frameHeight)
        buttonView_0.frameCenterY = self.frameHeight / 2
//        buttonView_1.frameCenterY = self.frameHeight / 2
        buttonView_2.frameCenterY = self.frameHeight / 2
//        buttonView_1.frameCenterX = frameWidth / 2
        buttonView_2.frameRight = frameWidth
        if switchType == .free {
            animationView.frameLeft = fitViewHeight(0)
        } else if switchType == .vip {
            animationView.frameCenterX = self.frameWidth / 2
        } else {
            animationView.frameRight = self.frameWidth - fitViewHeight(10)
        }
    }
    
    func updateStatus(status: AddressPressListSwitchType) {
        if status == switchType {
            return
        }
        switchType = status
        if switchType == .free {
            buttonView_0.setTitleColor(UIColor(red: 16/255, green: 16/255, blue: 16/255, alpha: 1), for: .normal)
            buttonView_2.setTitleColor(UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1), for: .normal)
        } else if switchType == .vip {
            buttonView_0.setTitleColor(UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1), for: .normal)
            buttonView_2.setTitleColor(UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1), for: .normal)
        } else {
            buttonView_2.setTitleColor(UIColor(red: 16/255, green: 16/255, blue: 16/255, alpha: 1), for: .normal)
            buttonView_0.setTitleColor(UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1), for: .normal)
        }
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    lazy var backView: UIView = {
        let resultView = UIView()
        resultView.backgroundColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
        resultView.layer.shadowColor = UIColor(red: 0.06, green: 0.06, blue: 0.06, alpha: 1).cgColor
        resultView.layer.shadowOffset = CGSize(width: 0, height: 4)
        resultView.layer.cornerRadius = fitViewHeight(15)
        resultView.layer.masksToBounds = true
        return resultView
    }()
        
    lazy var animationView: UIView = {
        let resultView = UIView()
        resultView.backgroundColor = UIColor(red:138/255, green: 255/255, blue: 232/255, alpha: 1)
        resultView.layer.shadowOffset = CGSize(width: 0, height: 4)
        resultView.layer.cornerRadius = fitViewHeight(12)
        resultView.layer.masksToBounds = true
        return resultView
    }()
    
    lazy var buttonView_0: UIButton = {
        let resultView = UIButton(type: .custom)
        resultView.setTitle("Free", for: .normal)
        resultView.setTitleColor(UIColor(red: 16/255, green: 16/255, blue: 16/255, alpha: 1), for: .normal)
        resultView.titleLabel?.font = UIFont.fitFont(.semiBold, 14)
        resultView.addTarget(self, action: #selector(buttonDidClick_0), for: .touchUpInside)
        return resultView
    }()

//    lazy var buttonView_1: UIButton = {
//        let resultView = UIButton(type: .custom)
//        resultView.setImage(UIImage(named: "vip_vip_title_icon"), for: .normal)
//        resultView.addTarget(self, action: #selector(buttonDidClick_1), for: .touchUpInside)
//        return resultView
//    }()

    lazy var buttonView_2: UIButton = {
        let resultView = UIButton(type: .custom)
        resultView.setTitle("Collection", for: .normal)
        resultView.setTitleColor(UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1), for: .normal)
        resultView.titleLabel?.font = UIFont.fitFont(.semiBold, 14)
        resultView.addTarget(self, action: #selector(buttonDidClick_2), for: .touchUpInside)
        return resultView
    }()
}

extension AddressPressListSwitchView {
    
    @objc func buttonDidClick_0(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.updateStatus(status: .free)
            if self?.viewBlock != nil {
                self?.viewBlock?(.free)
            }
        }
    }
    
//    @objc func buttonDidClick_1(_ sender: UIButton) {
//        UIView.animate(withDuration: 0.5) { [weak self] in
//            self?.updateStatus(status: .vip)
//            if self?.viewBlock != nil {
//                self?.viewBlock?(.vip)
//            }
//        }
//    }
    
    @objc func buttonDidClick_2(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.updateStatus(status: .collect)
            if self?.viewBlock != nil {
                self?.viewBlock?(.collect)
            }
        }
    }
    
    
    
}
