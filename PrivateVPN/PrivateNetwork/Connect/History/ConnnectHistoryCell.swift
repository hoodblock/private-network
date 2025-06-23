//
//  ConnnectHistoryCell.swift
//  PrivateNetwork
//
//  Created by Thomas on 2024/12/5.
//

import UIKit

class ConnnectHistoryCell: UICollectionViewCell {
    
    static let identifier = "ConnnectHistoryCell"
    
    private var itemModel: RegionItem = RegionItem()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
        contentView.layer.cornerRadius = 20
        contentView.addSubview(cityImageView)
        contentView.addSubview(countryLabel)
        contentView.addSubview(cityLabel)
        contentView.addSubview(timeStaticLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(timeBackView)
        contentView.addSubview(timeView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cityImageView.frameTop = fitViewHeight(15)
        cityImageView.frameCenterX = frameWidth / 2
        countryLabel.frameTop = cityImageView.frameBottom + fitViewHeight(10)
        countryLabel.frameCenterX = frameWidth / 2
        cityLabel.frameTop = countryLabel.frameBottom + fitViewHeight(10)
        cityLabel.frameCenterX = frameWidth / 2
        timeBackView.frameBottom = frameHeight - fitViewHeight(15)
        timeBackView.frameCenterX = frameWidth / 2
        timeStaticLabel.frameBottom = timeBackView.frameTop - fitViewHeight(2)
        timeStaticLabel.frameLeft = timeBackView.frameLeft
        timeLabel.frameCenterY = timeStaticLabel.frameCenterY
        timeLabel.frameRight = timeBackView.frameRight
        timeView.frameCenterY = timeBackView.frameCenterY
        timeView.frameLeft = timeBackView.frameLeft
    }
    
    func configure(item: RegionItem) {
        self.itemModel = item
        cityImageView.image = UIImage(named: itemModel.regionIcon ?? "")
        countryLabel.text = itemModel.regionCountry
        countryLabel.sizeToFit()
        cityLabel.text = itemModel.regionCity
        cityLabel.sizeToFit()
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    lazy var cityImageView: UIImageView = {
        let resultView = UIImageView()
        resultView.frameSize = CGSize(width: fitViewHeight(60), height: fitViewHeight(40))
        resultView.layer.cornerRadius = fitViewHeight(5)
        resultView.layer.masksToBounds = true
        return resultView
    }()
    
    lazy var countryLabel: UILabel = {
        let resultView = UILabel()
        resultView.font = UIFont.fitFont(.semiBold, 14)
        resultView.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        resultView.sizeToFit()
        return resultView
    }()
    
    lazy var cityLabel: UILabel = {
        let resultView = UILabel()
        resultView.font = UIFont.fitFont(.regular, 12)
        resultView.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
        resultView.sizeToFit()
        return resultView
    }()
    
    lazy var timeStaticLabel: UILabel = {
        let resultView = UILabel()
        resultView.font = UIFont.fitFont(.regular, 8)
        resultView.text = "Time"
        resultView.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
        resultView.sizeToFit()
        return resultView
    }()
    
    lazy var timeLabel: UILabel = {
        let resultView = UILabel()
        resultView.font = UIFont.fitFont(.regular, 8)
        resultView.text = "00:00:00"
        resultView.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
        resultView.sizeToFit()
        return resultView
    }()
 
    lazy var timeBackView: UIView = {
        let resultView = UIView()
        resultView.backgroundColor = UIColor(red: 62/255, green: 62/255, blue: 62/255, alpha: 1)
        resultView.frameHeight = fitViewHeight(6)
        resultView.frameWidth = self.frameWidth - fitViewHeight(30)
        resultView.layer.cornerRadius = fitViewHeight(3)
        resultView.layer.masksToBounds = true
        return resultView
    }()
    
    lazy var timeView: UIView = {
        let resultView = UIView()
        resultView.backgroundColor = UIColor(red: 138/255, green: 255/255, blue: 232/255, alpha: 1)
        resultView.frameHeight = fitViewHeight(6)
        resultView.layer.cornerRadius = fitViewHeight(3)
        resultView.layer.masksToBounds = true
        return resultView
    }()
    
}
