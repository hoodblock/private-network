//
//  AddressPressItemCell.swift
//  V608
//
//  Created by Thomas on 2024/9/19.
//

import UIKit

enum AddressPressCellType {
    case free
    case vip
    case collect
}

typealias AddressPressCellBlock = (_ item: RegionItem) -> ()

class AddressPressItemCell: UITableViewCell {
    
    var currentType: AddressPressCellType = .free
    var item: RegionItem = RegionItem()
    var addressCellClickBlocK: AddressPressCellBlock?
    var updateCollectCellBlocK: AddressPressCellBlock?

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(backView)
        self.contentView.addSubview(cityImageView)
        self.contentView.addSubview(titleLabel_0)
        self.contentView.addSubview(titleLabel_1)
        self.contentView.addSubview(titleLabel_2)
        self.contentView.addSubview(backButtonView)
        self.contentView.addSubview(buttonView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backView.frameSize = CGSize(width: self.frameWidth - fitViewHeight(20) * 2, height: self.frameHeight - fitViewHeight(15))
        backView.frameCenterX = self.frameWidth / 2
        backView.frameBottom = self.frameHeight
        backButtonView.frameSize = backView.frameSize
        backButtonView.frameCenterY = backView.frameCenterY
        backButtonView.frameCenterX = backView.frameCenterX
        cityImageView.frameCenterY = backView.frameCenterY
        cityImageView.frameLeft = backView.frameLeft + fitViewHeight(20)
        titleLabel_0.frameLeft = cityImageView.frameRight + fitViewHeight(10)
        titleLabel_1.frameLeft = cityImageView.frameRight + fitViewHeight(10)
        titleLabel_0.frameBottom = cityImageView.frameCenterY - fitViewHeight(5)
        titleLabel_1.frameTop = cityImageView.frameCenterY + fitViewHeight(5)
        titleLabel_2.frameCenterY = backView.frameCenterY
        buttonView.frameCenterY = backView.frameCenterY
        buttonView.frameRight = backView.frameRight - fitViewHeight(20)
        titleLabel_2.frameRight = buttonView.frameLeft - fitViewHeight(10)
    }
    
    func updateModel(_ item: RegionItem) {
        self.item = item
        if currentType == .vip {
            buttonView.setImage(UIImage(named: "vip_glob_icon"), for: .normal)
        } else {
            if item.regioncCollected {
                buttonView.setImage(UIImage(named: "feedback_select_icon"), for: .normal)
            } else {
                buttonView.setImage(UIImage(named: "feedback_default_icon"), for: .normal)
            }
        }
        if item.regionSelected {
            backView.backgroundColor = UIColor(red: 138/255, green: 255/255, blue: 232/255, alpha: 0.3)
            backView.layer.borderWidth = fitViewHeight(1)
            backView.layer.borderColor = UIColor(red: 138/255, green: 255/255, blue: 232/255, alpha: 3).cgColor
            backView.layer.shadowOffset = CGSize(width: 0, height: 4)
            backView.layer.cornerRadius = fitViewHeight(15)
            backView.layer.masksToBounds = true
        } else {
            backView.backgroundColor = UIColor.clear
            backView.layer.borderWidth = fitViewHeight(1)
            backView.layer.borderColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.3).cgColor
            backView.layer.shadowOffset = CGSize(width: 0, height: 4)
            backView.layer.cornerRadius = fitViewHeight(15)
            backView.layer.masksToBounds = true
        }
        if item.regionPing < 300 {
            titleLabel_2.textColor = UIColor(red: 0/255, green: 250/255, blue: 130/255, alpha: 1)
        } else if item.regionPing < 600 {
            titleLabel_2.textColor = UIColor(red: 255/255, green: 168/255, blue: 0/255, alpha: 1)
        } else {
            titleLabel_2.textColor = UIColor(red: 255/255, green: 1/255, blue: 1/255, alpha: 1)
        }
        titleLabel_2.text = String(format: "%0.2f ms", item.regionPing)
        titleLabel_2.sizeToFit()
        cityImageView.image = UIImage(named: item.regionIcon ?? "")
        
        titleLabel_0.text = item.regionCountry ?? ""
        titleLabel_0.sizeToFit()
        
        titleLabel_1.text = item.regionCity ?? ""
        titleLabel_1.sizeToFit()
    }
    
    lazy var backView: UIView = {
        let resultView = UIView()
        return resultView
    }()
    
    lazy var cityImageView: UIImageView = {
        let resultView = UIImageView()
        resultView.frameSize = CGSize(width: fitViewHeight(60), height: fitViewHeight(40))
        resultView.layer.cornerRadius = fitViewHeight(5)
        resultView.layer.masksToBounds = true
        return resultView
    }()
    
    lazy var titleLabel_0: UILabel = {
        let resultView = UILabel()
        resultView.text = "Expires"
        resultView.font = UIFont.fitFont(.semiBold, 14)
        resultView.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        resultView.sizeToFit()
        return resultView
    }()
    
    lazy var titleLabel_1: UILabel = {
        let resultView = UILabel()
        resultView.text = "Expires"
        resultView.font = UIFont.fitFont(.regular, 12)
        resultView.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
        resultView.sizeToFit()
        return resultView
    }()
    
    lazy var titleLabel_2: UILabel = {
        let resultView = UILabel()
        resultView.text = "10ms"
        resultView.font = UIFont.fitFont(.regular, 13)
        resultView.textColor = UIColor(red: 0/255, green: 250/255, blue: 130/255, alpha: 1)
        resultView.sizeToFit()
        return resultView
    }()
    
    lazy var buttonView: UIButton = {
        let resultView = UIButton(type: .custom)
        resultView.setImage(UIImage(named: "connect_main_address_icon"), for: .normal)
        resultView.frameSize = CGSize(width: fitViewHeight(20), height: fitViewHeight(20))
        resultView.addTarget(self, action: #selector(buttonDidClick_0), for: .touchUpInside)
        return resultView
    }()
    
    lazy var backButtonView: UIButton = {
        let resultView = UIButton(type: .custom)
        resultView.addTarget(self, action: #selector(buttonDidClick_1), for: .touchUpInside)
        return resultView
    }()
}

extension AddressPressItemCell {
    
    @objc func buttonDidClick_0(_ sender: UIButton) {
        if currentType == .vip {
            return
        }
        if updateCollectCellBlocK != nil {
            updateCollectCellBlocK!(item)
        }
    }
    
    @objc func buttonDidClick_1(_ sender: UIButton) {
        if addressCellClickBlocK != nil {
            addressCellClickBlocK!(item)
        }
    }
}

