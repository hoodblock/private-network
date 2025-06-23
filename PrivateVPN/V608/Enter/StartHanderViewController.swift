//
//  StartHanderViewController.swift
//  V608
//
//  Created by Thomas on 2024/9/6.
//

import UIKit

// 授权页，第一次下载的时候使用，授权网络弹窗和tranking的弹窗
class StartHanderViewController : UIViewController {
    
    var viewBlock: ViewBlock?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.addSubview(backImageView)
        view.addSubview(titleLabel_0)
        view.addSubview(titleLabel_1)
        view.addSubview(bottomButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        backImageView.frame = view.bounds
        bottomButton.frameSize = CGSize(width: view.frameWidth - fitViewHeight(20) * 2, height: fitViewHeight(52))
        bottomButton.frameCenterX = view.frameCenterX
        bottomButton.frameBottom = view.frameHeight - view.fitViewHeight(60)
        titleLabel_0.frameCenterX = view.frameCenterX
        titleLabel_1.frameCenterX = view.frameCenterX
        titleLabel_1.frameBottom = bottomButton.frameTop - view.fitViewHeight(60)
        titleLabel_0.frameBottom = titleLabel_1.frameTop - view.fitViewHeight(20)
    }
    
    lazy var backImageView: UIImageView = {
        let resultView = UIImageView()
        resultView.image = UIImage(named: "enhancedHander_backgroud_icon")
        return resultView
    }()
    
    lazy var titleLabel_0: UILabel = {
        let resultView = UILabel()
        resultView.text = "Enhanced Privacy"
        resultView.font = UIFont.fitFont(.bold, 28)
        resultView.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        resultView.sizeToFit()
        return resultView
    }()
    
    lazy var titleLabel_1: UILabel = {
        let resultView = UILabel()
        resultView.text = "We encrypt your connection, ensuring your data remains pirate and Secure."
        resultView.font = UIFont.fitFont(.regular, 14)
        resultView.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
        resultView.heightAuthSize(view.frameWidth - fitViewHeight(20) * 2)
        resultView.numberOfLines = 0
        resultView.textAlignment = .center
        return resultView
    }()
    
    lazy var bottomButton: ImageTitleButton = {
        let resultView = ImageTitleButton()
        resultView.createTitleImageButton(title: "Let‘s GO", titleColor: UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1), titleFont: UIFont.fitFont(.bold, 14), imageName: "to_right_black_icon", imageSize: CGSize(width: UIView.fitViewHeight(20), height: UIView.fitViewHeight(10)), cornerRadius: UIView.fitViewHeight(26), backgroundColor: UIColor(red: 40/255, green: 255/255, blue: 207/255, alpha: 1))
        resultView.viewBlock = { [weak self] in
            if self?.viewBlock != nil {
                self?.viewBlock!()
            }
        }
        return resultView
    }()
}


