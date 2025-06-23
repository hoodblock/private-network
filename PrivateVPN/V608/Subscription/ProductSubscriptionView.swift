//
//  ProductSubscriptionView.swift
//  V608
//
//  Created by Thomas on 2024/9/14.
//

import UIKit

enum ProductSubscriptionShowType {
    case simple
    case detail
}

class ProductSubscriptionItem: UIView {
    
    var currentProductSubscriptionType: ProductSubscriptionShowType = .simple
    var viewBlock: ViewBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backView)
        addSubview(buttonView)
        addSubview(rightImageView)
        addSubview(titleLabel_0)
        addSubview(titleLabel_1)
        addSubview(titleLabel_2)
        addSubview(titleLabel_3)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if currentProductSubscriptionType == .simple {
            backView.frameSize = CGSize(width: self.frameWidth, height: self.frameHeight - fitViewHeight(20))
            backView.frameCenterY = self.frameHeight / 2
            backView.frameCenterX = self.frameWidth / 2

            buttonView.frameSize = CGSize(width: self.frameWidth, height: self.frameHeight - fitViewHeight(20))
            buttonView.frameCenterY = self.frameHeight / 2
            buttonView.frameCenterX = self.frameWidth / 2
            
            titleLabel_2.frameLeft = backView.frameLeft + fitViewHeight(20)
            titleLabel_3.frameRight = backView.frameRight - fitViewHeight(20)
            titleLabel_2.frameCenterY = backView.frameCenterY
            titleLabel_3.frameCenterY = backView.frameCenterY
        } else {
            backView.frameSize = self.frameSize
            backView.frameCenterY = self.frameHeight / 2
            backView.frameCenterX = self.frameWidth / 2
            
            buttonView.frameSize = CGSize(width: self.backView.frameWidth - fitViewHeight(10), height: self.backView.frameHeight - fitViewHeight(10))
            buttonView.frameCenterY = self.frameHeight / 2
            buttonView.frameCenterX = self.frameWidth / 2
            
            titleLabel_0.frameLeft = buttonView.frameLeft + fitViewHeight(20)
            titleLabel_2.frameLeft = buttonView.frameLeft + fitViewHeight(20)
            titleLabel_3.frameRight = buttonView.frameRight - fitViewHeight(20)
            titleLabel_0.frameTop = buttonView.frameTop + fitViewHeight(10)
            titleLabel_2.frameBottom = buttonView.frameBottom - fitViewHeight(10)
            titleLabel_3.frameBottom = buttonView.frameBottom - fitViewHeight(10)
            rightImageView.frameSize = CGSize(width: titleLabel_1.frameWidth + fitViewHeight(20), height: titleLabel_1.frameHeight + fitViewHeight(10))
            rightImageView.frameRight = buttonView.frameRight - fitViewHeight(20)
            rightImageView.frameCenterY = titleLabel_0.frameCenterY
            titleLabel_1.frameCenterY = rightImageView.frameCenterY
            titleLabel_1.frameCenterX = rightImageView.frameCenterX
            backView.layer.cornerRadius = fitViewHeight(15)
            backView.layer.borderColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1).cgColor
            backView.layer.borderWidth = fitViewHeight(2)
            backView.layer.masksToBounds = true
        }
        buttonView.layer.cornerRadius = fitViewHeight(15)
        buttonView.layer.masksToBounds = true
    }
    
    func updateStatus(_ status: ProductSubscriptionShowType) {
        currentProductSubscriptionType = status
        if currentProductSubscriptionType == .simple {
            titleLabel_0.isHidden = true
            titleLabel_1.isHidden = true
            rightImageView.isHidden = true
            backView.isHidden = true
            buttonView.backgroundColor = UIColor(red: 160/255, green: 163/255, blue: 162/255, alpha: 1)
        } else {
            titleLabel_0.isHidden = false
            titleLabel_1.isHidden = false
            rightImageView.isHidden = false
            backView.isHidden = false
            buttonView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        }
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    lazy var titleLabel_0: UILabel = {
        let resultView = UILabel()
        resultView.text = "Monthly Plan"
        resultView.font = UIFont.fitFont(.medium, 11)
        resultView.textColor = UIColor(red: 16/255, green: 16/255, blue: 16/255, alpha: 1)
        resultView.sizeToFit()
        return resultView
    }()
    
    lazy var titleLabel_1: UILabel = {
        let resultView = UILabel()
        resultView.text = "save $8 / month"
        resultView.font = UIFont.fitFont(.medium, 10)
        resultView.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        resultView.sizeToFit()
        return resultView
    }()
    
    lazy var titleLabel_2: UILabel = {
        let resultView = UILabel()
        resultView.text = "$7.99/Month"
        resultView.font = UIFont.fitFont(.bold, 14)
        resultView.textColor = UIColor(red: 16/255, green: 16/255, blue: 16/255, alpha: 1)
        resultView.sizeToFit()
        return resultView
    }()
    
    lazy var titleLabel_3: UILabel = {
        let resultView = UILabel()
        resultView.text = "$15.99/month"
        resultView.font = UIFont.fitFont(.semiBold, 12)
        resultView.textColor = UIColor(red: 106/255, green: 100/255, blue: 113/255, alpha: 1)
        resultView.sizeToFit()
        return resultView
    }()
    
    lazy var rightImageView: UIImageView = {
        let resultView = UIImageView()
        resultView.image = UIImage(named: "vip_grade_min_background_icon")
        return resultView
    }()
    
    lazy var buttonView: UIButton = {
        let resultView = UIButton(type: .custom)
        resultView.backgroundColor = UIColor(red: 160/255, green: 169/255, blue: 167/255, alpha: 1)
        resultView.addTarget(self, action: #selector(buttonDidClick), for: .touchUpInside)
        return resultView
    }()
    
    @objc func buttonDidClick(_ sender: UIButton) {
        if viewBlock != nil {
            viewBlock!()
        }
    }
    
    lazy var backView: UIView = {
        let resultView = UIView()
        resultView.backgroundColor = UIColor(red: 19/255, green: 46/255, blue: 40/255, alpha: 1)
        return resultView
    }()
}





class ProductSubscriptionView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(item_0)
        addSubview(item_1)
        addSubview(item_2)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        item_0.frameSize = CGSize(width: self.frameWidth, height: self.frameHeight / 3)
        item_1.frameSize = CGSize(width: self.frameWidth, height: self.frameHeight / 3)
        item_2.frameSize = CGSize(width: self.frameWidth, height: self.frameHeight / 3)
        item_0.frameTop = 0
        item_1.frameCenterY = self.frameHeight / 2
        item_2.frameBottom = self.frameHeight
    }
    
    /// 0-1-2
    func updateSubscriptionStatus(_ selected: Int) {
        UIView.animate(withDuration: 0.3) {[weak self] in
            if selected == 0 {
                self?.item_0.updateStatus(.detail)
                self?.item_1.updateStatus(.simple)
                self?.item_2.updateStatus(.simple)
            } else if selected == 1 {
                self?.item_0.updateStatus(.simple)
                self?.item_1.updateStatus(.detail)
                self?.item_2.updateStatus(.simple)
            } else {
                self?.item_0.updateStatus(.simple)
                self?.item_1.updateStatus(.simple)
                self?.item_2.updateStatus(.detail)
            }
        }
    }
    
    lazy var item_0: ProductSubscriptionItem = {
        let resultView = ProductSubscriptionItem()
        resultView.updateStatus(.detail)
        resultView.viewBlock = {[weak self] in
            self?.updateSubscriptionStatus(0)
        }
        return resultView
    }()
    
    lazy var item_1: ProductSubscriptionItem = {
        let resultView = ProductSubscriptionItem()
        resultView.updateStatus(.simple)
        resultView.viewBlock = {[weak self] in
            self?.updateSubscriptionStatus(1)
        }
        return resultView
    }()
    
    lazy var item_2: ProductSubscriptionItem = {
        let resultView = ProductSubscriptionItem()
        resultView.updateStatus(.simple)
        resultView.viewBlock = {[weak self] in
            self?.updateSubscriptionStatus(2)
        }
        return resultView
    }()
}
