//
//  ConnectTimeConfigView.swift
//  V608
//
//  Created by Thomas on 2024/11/12.
//

import UIKit

typealias View_60_Block = () -> (Void)
typealias View_120_Block = () -> (Void)

class ConnectTimeConfigView: UIView {
    
    var view_60_Block: View_60_Block?
    var view_120_Block: View_120_Block?

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(buttonView_60)
        addSubview(buttonView_120)
        addSubview(leftLabel)
        addSubview(rightImageView)
        addSubview(rightLabel)
        addSubview(buttonView_ad)
        addSubview(rightAdImageView)
        addSubview(rightAdLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        buttonView_60.frameLeft = fitViewHeight(20)
        buttonView_120.frameRight = frameWidth - fitViewHeight(20)
        buttonView_60.frameSize = CGSize(width: Int((frameWidth - fitViewHeight(20) * 2)) / 2, height: Int((frameWidth - fitViewHeight(20) * 2)) / 2 * 66 / 171)
        buttonView_120.frameSize = CGSize(width: Int((frameWidth - fitViewHeight(20) * 2)) / 2, height: Int((frameWidth - fitViewHeight(20) * 2)) / 2 * 66 / 171)
        buttonView_60.frameCenterY = frameHeight / 2
        buttonView_120.frameCenterY = frameHeight / 2
        leftLabel.frameCenterY = buttonView_60.frameCenterY
        leftLabel.frameCenterX = buttonView_60.frameCenterX
        rightImageView.frameCenterY = buttonView_120.frameCenterY
        rightLabel.frameCenterY = buttonView_120.frameCenterY
        rightImageView.frameLeft = buttonView_120.frameLeft + (buttonView_120.frameWidth - rightLabel.frameWidth - rightImageView.frameWidth - fitViewHeight(10)) / 2
        rightLabel.frameLeft = rightImageView.frameRight + fitViewHeight(10)
        buttonView_ad.frameSize = CGSize(width: buttonView_60.frameWidth / 4, height: buttonView_60.frameHeight / 4)
        buttonView_ad.frameRight = buttonView_120.frameRight
        buttonView_ad.frameBottom = buttonView_120.frameBottom
        rightAdImageView.frameLeft = buttonView_ad.frameLeft + (buttonView_ad.frameWidth - rightAdLabel.frameWidth - rightAdImageView.frameWidth - fitViewHeight(5)) / 2
        rightAdLabel.frameLeft = rightAdImageView.frameRight + fitViewHeight(5)
        rightAdImageView.frameCenterY = buttonView_ad.frameCenterY
        rightAdLabel.frameCenterY = buttonView_ad.frameCenterY
    }
    
    lazy var buttonView_60: UIButton = {
        let resultView = UIButton(type: .custom)
        resultView.setBackgroundImage(UIImage(named: "back_left_icon"), for: .normal)
//        resultView.back(UIImage(named: "back_left_icon"), for: .normal)
        resultView.addTarget(self, action: #selector(buttonDidClick_60), for: .touchUpInside)
        return resultView
    }()
    
    lazy var buttonView_120: UIButton = {
        let resultView = UIButton(type: .custom)
        resultView.setBackgroundImage(UIImage(named: "back_right_icon"), for: .normal)
        resultView.addTarget(self, action: #selector(buttonDidClick_120), for: .touchUpInside)
        return resultView
    }()
 
    lazy var leftLabel: UILabel = {
        let resultView = UILabel()
        resultView.text = "+60 Mins"
        resultView.font = UIFont.fitFont(.regular, 16)
        resultView.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        resultView.sizeToFit()
        return resultView
    }()
    
    lazy var rightLabel: UILabel = {
        let resultView = UILabel()
        resultView.text = "+120 Mins"
        resultView.font = UIFont.fitFont(.regular, 16)
        resultView.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        resultView.sizeToFit()
        return resultView
    }()
    
    lazy var rightAdLabel: UILabel = {
        let resultView = UILabel()
        resultView.text = "AD"
        resultView.font = UIFont.fitFont(.regular, 10)
        resultView.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        resultView.sizeToFit()
        return resultView
    }()
    
    lazy var rightImageView: UIImageView = {
        let resultView = UIImageView()
        resultView.image = UIImage(named: "alert_time_icon")
        resultView.frameSize = CGSize(width: fitViewHeight(22), height: fitViewHeight(22))
        return resultView
    }()
    
    lazy var rightAdImageView: UIImageView = {
        let resultView = UIImageView()
        resultView.image = UIImage(named: "back_ad_icon")
        resultView.frameSize = CGSize(width: fitViewHeight(10), height: fitViewHeight(10))
        return resultView
    }()

    lazy var buttonView_ad: UIButton = {
        let resultView = UIButton(type: .custom)
        resultView.layer.borderWidth = 1
        resultView.layer.borderColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.4).cgColor
        resultView.layer.cornerRadius = 8
        resultView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.1)
        resultView.setImage(UIImage(named: "back_left_icon"), for: .normal)
        return resultView
    }()
    
}

extension ConnectTimeConfigView {
    
    @objc func buttonDidClick_60(_ sender: UIButton) {
        if view_60_Block != nil {
            view_60_Block!()
        }
    }
    
    @objc func buttonDidClick_120(_ sender: UIButton) {
        if view_120_Block != nil {
            view_120_Block!()
        }
    }
}
