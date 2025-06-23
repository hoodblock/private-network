//
//  ShowTimerStatusAlertView.swift
//  PrivateNetwork
//
//  Created by Thomas on 2024/11/11.
//

import UIKit

/// 二次续时间吧，续时间结果页

class ShowTimerStatusAlertView: UIView {

    var clickBlock: AlertViewButtonDidClickBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        // 底部
        backgroundColor = UIColor(red: 117/255, green: 117/255, blue: 117/255, alpha: 0.8)
        layer.cornerRadius = 12
        layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.15).cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 10
        
        addSubview(titleLabel)
        addSubview(timeLabel)
        addSubview(tipsLabel)
        addSubview(bottomBackView)
        addSubview(bottomTimeLabel)
        addSubview(actionButton)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frameCenterX = self.frameWidth / 2
        timeLabel.frameCenterX = self.frameWidth / 2
        tipsLabel.frameCenterX = self.frameWidth / 2
        bottomBackView.frameSize = CGSize(width: bottomTimeLabel.frameWidth + 20 * 2, height: bottomTimeLabel.frameHeight * 2)
        bottomBackView.frameCenterX = self.frameWidth / 2
        bottomTimeLabel.frameCenterX = bottomBackView.frameCenterX
        titleLabel.frameTop = 28
        bottomBackView.frameBottom = frameHeight - 25
        tipsLabel.frameBottom = bottomBackView.frameTop - 15
        timeLabel.frameTop = titleLabel.frameBottom + 6
        bottomTimeLabel.frameCenterY = bottomBackView.frameCenterY
        actionButton.frameSize = bottomBackView.frameSize
        actionButton.center = bottomBackView.center
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.text = "Connect remain time"
        label.sizeToFit()
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.textAlignment = .center
        label.textColor = UIColor(red: 138/255, green: 255/255, blue: 232/255, alpha: 1)
        label.text = "+120 Mins"
        label.sizeToFit()
        return label
    }()
    
    private let tipsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.8)
        label.text = "Your remaining time is \(NetworkManager.shared.formatTime())"
        label.sizeToFit()
        return label
    }()
    
    private let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(buttonDidClick), for: .touchUpInside)
        return button
    }()
    
    private let bottomBackView: UIView = {
        let resultView = UIView()
        resultView.layer.backgroundColor = UIColor(red: 44/255, green: 57/255, blue: 54/255, alpha: 1).cgColor
        resultView.layer.cornerRadius = fitViewHeight(12)
        return resultView
    }()
    
    private let bottomTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        label.text = "Confirm"
        label.sizeToFit()
        return label
    }()
    
}


extension ShowTimerStatusAlertView {
    
    @objc func buttonDidClick(_ sender: UIButton) {
        if clickBlock != nil {
            clickBlock!()
        }
        dismiss()
    }
    
    private func dismiss() {
        self.removeFromSuperview()
    }
    
}
