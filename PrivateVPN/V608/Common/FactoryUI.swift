//
//  FactoryUI.swift
//  V608
//
//  Created by Thomas on 2024/9/9.
//

import UIKit

enum ImageTitleType {
    case leftTitleRightImage
    case leftImageRightTitle
}

class ImageTitleButton: UIView {
    
    var viewBlock: ViewBlock?
    
    var imageType: ImageTitleType = .leftTitleRightImage
    
    private var magin: CGFloat = fitViewHeight(40)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backButton)
        addSubview(imageView)
        addSubview(titleLabel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createTitleImageButton(title: String, titleColor: UIColor, titleFont: UIFont, imageName: String, imageSize: CGSize, cornerRadius: CGFloat, backgroundColor: UIColor, magin: CGFloat = fitViewHeight(40)) {
        titleLabel.text = title
        titleLabel.textColor = titleColor
        titleLabel.font = titleFont
        titleLabel.sizeToFit()
        imageView.image = UIImage(named: imageName)
        imageView.frameSize = imageSize
        backButton.backgroundColor = backgroundColor
        backButton.layer.cornerRadius = cornerRadius
        backButton.layer.masksToBounds = true
        self.magin = magin
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        backButton.frameSize = self.frameSize
        imageView.frameCenterY = self.frameHeight / 2
        titleLabel.frameCenterY = self.frameHeight / 2
        if imageType == .leftTitleRightImage {
            titleLabel.frameLeft = self.frameWidth / 2 -  (titleLabel.frameWidth + imageView.frameWidth + magin) / 2
            imageView.frameLeft = titleLabel.frameRight + magin
        } else {
            imageView.frameLeft = self.frameWidth / 2 -  (titleLabel.frameWidth + imageView.frameWidth + magin) / 2
            titleLabel.frameLeft = imageView.frameRight + magin
        }
       
    }
    
    lazy var imageView: UIImageView = {
        let resultView = UIImageView()
        return resultView
    }()
    
    lazy var titleLabel: UILabel = {
        let resultView = UILabel()
        resultView.font = UIFont.fitFont(.bold, 18)
        resultView.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        return resultView
    }()
    
    lazy var backButton: UIButton = {
        let resultView = UIButton(type: .custom)
        resultView.addTarget(self, action: #selector(imageTitleButtonDidClick), for: .touchUpInside)
        return resultView
    }()
    
}

extension ImageTitleButton {
    
    @objc func imageTitleButtonDidClick(_ sender: UIButton) {
        if self.viewBlock != nil {
            viewBlock!()
        }
    }
}
