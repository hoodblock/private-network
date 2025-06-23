//
//  ShowActionAlertView.swift
//  V608
//
//  Created by Thomas on 2024/12/4.
//

import UIKit


class ShowActionAlertView: UIView {

    var clickLeftBlock: AlertViewButtonDidClickBlock?
    var clickRightBlock: AlertViewButtonDidClickBlock?

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
        addSubview(tipsLabel)
        addSubview(bottomLeftBackView)
        addSubview(bottomLeftLabel)
        addSubview(leftActionButton)
        addSubview(bottomRightBackView)
        addSubview(bottomRightLabel)
        addSubview(rightActionButton)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frameCenterX = self.frameWidth / 2
        titleLabel.frameTop = 30
        tipsLabel.heightAuthSize(self.frameWidth - fitViewHeight(40))
        tipsLabel.frameCenterX = self.frameWidth / 2
        tipsLabel.frameCenterY = frameHeight / 2
        bottomLeftBackView.frameSize = CGSize(width: bottomLeftLabel.frameWidth + 20 * 2, height: bottomLeftLabel.frameHeight * 2)
        bottomRightBackView.frameSize = CGSize(width: bottomRightLabel.frameWidth + 20 * 2, height: bottomRightLabel.frameHeight * 2)
        bottomLeftBackView.frameBottom = frameHeight - 25
        bottomRightBackView.frameBottom = frameHeight - 25
        bottomLeftBackView.frameRight = self.frameWidth / 2 - 20
        bottomRightBackView.frameLeft = self.frameWidth / 2 + 20
        bottomLeftLabel.frameCenterX = bottomLeftBackView.frameCenterX
        bottomLeftLabel.frameCenterY = bottomLeftBackView.frameCenterY
        bottomRightLabel.frameCenterX = bottomRightBackView.frameCenterX
        bottomRightLabel.frameCenterY = bottomRightBackView.frameCenterY
        leftActionButton.frameSize = bottomLeftBackView.frameSize
        leftActionButton.center = bottomLeftBackView.center
        rightActionButton.frameSize = bottomRightBackView.frameSize
        rightActionButton.center = bottomRightBackView.center
    }
    
    func updateTitle(title: String, message: String, leftButtonTitle: String, rightButtonTitle: String) {
        titleLabel.text = title
        titleLabel.sizeToFit()
        tipsLabel.text = message
        if !leftButtonTitle.isEmpty {
            bottomLeftLabel.text = leftButtonTitle
            bottomLeftLabel.sizeToFit()
        }
        if !rightButtonTitle.isEmpty {
            bottomRightLabel.text = rightButtonTitle
            bottomRightLabel.sizeToFit()
        }
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.text = "Tips"
        label.sizeToFit()
        return label
    }()
    
    private let tipsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.8)
        label.text = "message report"
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    private let leftActionButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(leftButtonDidClick), for: .touchUpInside)
        return button
    }()
    
    private let bottomLeftBackView: UIView = {
        let resultView = UIView()
        resultView.layer.backgroundColor = UIColor(red: 44/255, green: 57/255, blue: 54/255, alpha: 1).cgColor
        resultView.layer.cornerRadius = fitViewHeight(12)
        return resultView
    }()
    
    private let bottomLeftLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        label.text = "Confirm"
        label.sizeToFit()
        return label
    }()
    
    private let rightActionButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(rightButtonDidClick), for: .touchUpInside)
        return button
    }()
    
    private let bottomRightBackView: UIView = {
        let resultView = UIView()
        resultView.layer.backgroundColor = UIColor(red: 44/255, green: 57/255, blue: 54/255, alpha: 1).cgColor
        resultView.layer.cornerRadius = fitViewHeight(12)
        return resultView
    }()
    
    private let bottomRightLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        label.text = "Confirm"
        label.sizeToFit()
        return label
    }()

}


extension ShowActionAlertView {
  
    @objc func leftButtonDidClick(_ sender: UIButton) {
        if clickLeftBlock != nil {
            clickLeftBlock!()
        }
        dismiss()
    }
    
    @objc func rightButtonDidClick(_ sender: UIButton) {
        if clickRightBlock != nil {
            clickRightBlock!()
        }
        dismiss()
    }
    
    private func dismiss() {
        self.removeFromSuperview()
    }
    
}
