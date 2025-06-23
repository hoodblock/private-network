//
//  ShowAnimationView.swift
//  PrivateNetwork
//
//  Created by Thomas on 2024/11/11.
//

import UIKit


class ShowAnimationView: UIView {

    var clickBlock: AlertViewButtonDidClickBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = UIColor(red: 117/255, green: 117/255, blue: 117/255, alpha: 0.8)
        layer.cornerRadius = 12
        layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.15).cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 10
        addSubview(titleLabel)
        addSubview(bottomTimeImageView)
        animation()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        bottomTimeImageView.frameCenterX = self.frameWidth / 2
        bottomTimeImageView.frameCenterY = self.frameHeight / 2 - 20
        titleLabel.frameCenterX = self.frameWidth / 2
        titleLabel.frameBottom = self.frameHeight - 25
    }
    
    func updateTitle(title: String = "Connecting...") {
        titleLabel.text = title
        titleLabel.sizeToFit()
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.text = "Connecting..."
        label.sizeToFit()
        return label
    }()
    
    private let bottomTimeImageView: UIImageView = {
        let resultView = UIImageView()
        resultView.image = UIImage(named: "animation_connect_icon")
        resultView.frameSize = CGSize(width: 100, height: 100)
        return resultView
    }()
    
}


extension ShowAnimationView {
    
    private func dismiss() {
        self.removeFromSuperview()
    }
    
    private func animation() {
        // 创建旋转动画
        let rotation = CABasicAnimation(keyPath: "transform.rotation")
        // 旋转角度为 360 度 (2 * π)
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 1.5  // 动画持续时间
        rotation.repeatCount = .infinity  // 无限循环
        // 设置动画的缓动函数来实现从慢到快的效果
        rotation.timingFunction = CAMediaTimingFunction(name: .easeIn)
        // 应用动画到图片
        bottomTimeImageView.layer.add(rotation, forKey: "rotateAnimation")
    }
    
}
