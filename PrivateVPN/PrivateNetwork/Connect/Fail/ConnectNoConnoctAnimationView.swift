//
//  ConnectNoConnoctAnimationView.swift
//  PrivateNetwork
//
//  Created by Thomas on 2024/9/14.
//

import UIKit

class ConnectNoConnoctAnimationView: UIView {
    
    var viewBlock: ViewBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backView)
        addSubview(buttonView_0)
        addSubview(titleLabel)
        addSubview(bottomImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backView.frameCenterX = self.frameWidth / 2
        backView.frameCenterY = self.frameHeight / 2
        buttonView_0.frameTop = backView.frameTop + fitViewHeight(10)
        buttonView_0.frameCenterX = backView.frameCenterX
        titleLabel.frameCenterX = backView.frameCenterX
        bottomImageView.frameCenterX = backView.frameCenterX
        bottomImageView.frameBottom = backView.frameBottom - fitViewHeight(20)
        titleLabel.frameBottom = bottomImageView.frameTop - fitViewHeight(10)
    }
    
    lazy var buttonView_0: UIButton = {
        let resultView = UIButton(type: .custom)
        resultView.setImage(UIImage(named: "connect_main_button_icon"), for: .normal)
        resultView.frameSize = CGSize(width: fitViewHeight(100), height: fitViewHeight(100))
        resultView.addTarget(self, action: #selector(buttonDidClick_0), for: .touchUpInside)
        return resultView
    }()
 
    lazy var titleLabel: UILabel = {
        let resultView = UILabel()
        resultView.text = "Connect"
        resultView.font = UIFont.fitFont(.medium, 14)
        resultView.textColor = UIColor(red: 138/255, green: 255/255, blue: 232/255, alpha: 1)
        resultView.sizeToFit()
        return resultView
    }()
    
    lazy var bottomImageView: UIImageView = {
        let resultView = UIImageView()
        resultView.image = UIImage(named: "to_bottom_green_icon")
        resultView.frameSize = CGSize(width: fitViewHeight(20), height: fitViewHeight(30))
        return resultView
    }()
    
    lazy var backView: UIView = {
        let resultView = UIView()
        resultView.backgroundColor = UIColor(red: 26/255, green: 40/255, blue: 36/255, alpha: 1)
        resultView.frameSize = CGSize(width: fitViewHeight(110), height: fitViewHeight(200))
        resultView.layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.1).cgColor
        resultView.layer.shadowOffset = CGSize(width: 0, height: 4)
        resultView.layer.cornerRadius = fitViewHeight(55)
        resultView.layer.masksToBounds = true
        return resultView
    }()
    
}

extension ConnectNoConnoctAnimationView {
    
    @objc func buttonDidClick_0(_ sender: UIButton) {
        if viewBlock != nil {
            viewBlock!()
        }
    }
    
}
