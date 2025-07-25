//
//  ConnectVIPHeaderView.swift
//  PrivateNetwork
//
//  Created by Thomas on 2024/9/18.
//

import UIKit

class ConnectVIPHeaderView: UIView {
    
    var viewBlock: ConnectDefaultHeaderViewBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backView)
        addSubview(buttonView_0)
        addSubview(buttonView_1)
        addSubview(buttonView_2)
        addSubview(titleLabel)
        addSubview(vipImageView)
        addSubview(buttonView_0_0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backView.frameBottom = self.frameHeight
        backView.frameLeft = fitViewHeight(20)
        buttonView_2.frameRight = self.frameWidth - fitViewHeight(20)
        buttonView_1.frameRight = buttonView_2.frameLeft - fitViewHeight(20)
        buttonView_0.frameCenterY = backView.frameCenterY
        buttonView_1.frameCenterY = backView.frameCenterY
        buttonView_2.frameCenterY = backView.frameCenterY
        buttonView_0.frameLeft = backView.frameLeft + fitViewHeight(5)
        titleLabel.frameLeft = buttonView_0.frameRight + fitViewHeight(5)
        vipImageView.frameLeft = buttonView_0.frameRight + fitViewHeight(5)
        titleLabel.frameBottom = buttonView_0.frameBottom
        vipImageView.frameTop = buttonView_0.frameTop
        buttonView_0_0.frameSize = backView.frameSize
        buttonView_0_0.frameCenterY = backView.frameCenterY
        buttonView_0_0.frameCenterX = backView.frameCenterX
    }
    
    lazy var buttonView_0: UIButton = {
        let resultView = UIButton(type: .custom)
        resultView.setImage(UIImage(named: "vip_glob_icon"), for: .normal)
        resultView.frameSize = CGSize(width: fitViewHeight(35), height: fitViewHeight(35))
        return resultView
    }()
    
    lazy var buttonView_0_0: UIButton = {
        let resultView = UIButton(type: .custom)
        resultView.addTarget(self, action: #selector(buttonDidClick_0), for: .touchUpInside)
        return resultView
    }()
 
    lazy var vipImageView: UIImageView = {
        let resultView = UIImageView()
        resultView.image = UIImage(named: "vip_vip_icon")
        resultView.frameSize = CGSize(width: fitViewHeight(24), height: fitViewHeight(10))
        return resultView
    }()
    
    lazy var titleLabel: UILabel = {
        let resultView = UILabel()
        resultView.text = "Expires on 2025.01.29"
        resultView.font = UIFont.fitFont(.medium, 14)
        resultView.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        resultView.sizeToFit()
        return resultView
    }()
    
    lazy var backView: UIView = {
        let resultView = UIView()
        resultView.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3)
        resultView.frameSize = CGSize(width: fitViewHeight(230), height: fitViewHeight(50))
        resultView.layer.shadowOffset = CGSize(width: 0, height: 4)
        resultView.layer.cornerRadius = fitViewHeight(25)
        resultView.layer.masksToBounds = true
        return resultView
    }()
    
    lazy var buttonView_1: UIButton = {
        let resultView = UIButton(type: .custom)
        resultView.setImage(UIImage(named: "connect_main_address_icon"), for: .normal)
        resultView.frameSize = CGSize(width: fitViewHeight(30), height: fitViewHeight(30))
        resultView.addTarget(self, action: #selector(buttonDidClick_1), for: .touchUpInside)
        return resultView
    }()
    
    lazy var buttonView_2: UIButton = {
        let resultView = UIButton(type: .custom)
        resultView.setImage(UIImage(named: "connect_main_speed_icon"), for: .normal)
        resultView.frameSize = CGSize(width: fitViewHeight(30), height: fitViewHeight(30))
        resultView.addTarget(self, action: #selector(buttonDidClick_2), for: .touchUpInside)
        return resultView
    }()
    
}

extension ConnectVIPHeaderView {
    
    @objc func buttonDidClick_0(_ sender: UIButton) {
//        if viewBlock != nil {
//            viewBlock!(.subscription)
//        }
    }
    
    @objc func buttonDidClick_1(_ sender: UIButton) {
        if viewBlock != nil {
            viewBlock!(.address)
        }
    }
    
    @objc func buttonDidClick_2(_ sender: UIButton) {
        if viewBlock != nil {
            viewBlock!(.speed)
        }
    }
    
}
