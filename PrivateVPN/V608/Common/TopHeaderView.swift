//
//  TopHeaderView.swift
//  V608
//
//  Created by Thomas on 2024/11/12.
//

import UIKit

class TopHeaderView: UIView {
    
    var viewBlock: ViewBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backButton)
        addSubview(titleLabel_1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backButton.frameLeft = fitViewHeight(20)
        titleLabel_1.frameCenterX = frameWidth / 2
        backButton.frameCenterY = frameHeight / 2
        titleLabel_1.frameCenterY = backButton.frameCenterY
    }
    
    func updateTitle(title: String) {
        titleLabel_1.text = title
        titleLabel_1.sizeToFit()
    }
    
    lazy var titleLabel_1: UILabel = {
        let resultView = UILabel()
        resultView.text = ""
        resultView.font = UIFont.fitFont(.semiBold, 18)
        resultView.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        resultView.sizeToFit()
        return resultView
    }()
    
    lazy var backButton: UIButton = {
        let resultView = UIButton(type: .custom)
        resultView.setImage(UIImage(named: "back_left_white_icon"), for: .normal)
        resultView.frameSize = CGSize(width: fitViewHeight(30), height: fitViewHeight(30))
        resultView.addTarget(self, action: #selector(buttonDidClick), for: .touchUpInside)
        return resultView
    }()
    
    @objc func buttonDidClick(_ sender: UIButton) {
        if viewBlock != nil {
            viewBlock!()
        }
    }
}
