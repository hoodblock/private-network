//
//  AddressPressListViewController.swift
//  PrivateNetwork
//
//  Created by Thomas on 2024/9/6.
//

import UIKit

class PressListHeaderView: UIView {
    
    var leftViewBlock: ViewBlock?
    var rightViewBlock: ViewBlock?

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(leftButton)
        addSubview(rightButton)
        addSubview(titleLabel_1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        leftButton.frameLeft = fitViewHeight(20)
        titleLabel_1.frameCenterX = frameWidth / 2
        leftButton.frameCenterY = frameHeight / 2
        titleLabel_1.frameCenterY = leftButton.frameCenterY
        rightButton.frameRight = self.frameWidth - fitViewHeight(20)
        rightButton.frameCenterY = frameHeight / 2
    }
    
    lazy var titleLabel_1: UILabel = {
        let resultView = UILabel()
        resultView.text = "Region Selection"
        resultView.font = UIFont.fitFont(.semiBold, 18)
        resultView.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        resultView.sizeToFit()
        return resultView
    }()
    
    lazy var leftButton: UIButton = {
        let resultView = UIButton(type: .custom)
        resultView.setImage(UIImage(named: "region_select_history_icon"), for: .normal)
        resultView.frameSize = CGSize(width: fitViewHeight(30), height: fitViewHeight(30))
        resultView.addTarget(self, action: #selector(leftButtonDidClick), for: .touchUpInside)
        return resultView
    }()
    
    lazy var rightButton: UIButton = {
        let resultView = UIButton(type: .custom)
        resultView.setImage(UIImage(named: "region_select_refrash_icon"), for: .normal)
        resultView.frameSize = CGSize(width: fitViewHeight(30), height: fitViewHeight(30))
        resultView.addTarget(self, action: #selector(rightButtonDidClick), for: .touchUpInside)
        return resultView
    }()
    
    @objc func leftButtonDidClick(_ sender: UIButton) {
        if leftViewBlock != nil {
            leftViewBlock!()
        }
    }
    
    @objc func rightButtonDidClick(_ sender: UIButton) {
        if rightViewBlock != nil {
            rightViewBlock!()
        }
    }
}


class AddressPressListViewController : UIViewController {
    
    var viewBlock: ViewBlock?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = UIColor(red: 16/255, green: 16/255, blue: 16/255, alpha: 1)
        view.addSubview(headerView)
        view.addSubview(tabbar)
        self.addChild(freeView)
//        self.addChild(vipView)
        self.addChild(collectView)
        view.addSubview(freeView.view)
//        view.addSubview(vipView.view)
        view.addSubview(collectView.view)
        tabbar.updateStatus(status: .free)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        CollectManager.shared.updateRegionItemCollect()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        headerView.frameSize = CGSize(width: view.frameWidth, height: fitViewHeight(50))
        headerView.frameTop = self.view.safeAreaInsets.top
        tabbar.frameSize = CGSize(width: view.frameWidth - fitViewHeight(20) * 2, height: fitViewHeight(45))
        tabbar.frameCenterX = view.frameCenterX
        tabbar.frameTop = headerView.frameBottom + fitViewHeight(20)
        freeView.view.frameSize = CGSize(width: view.frameWidth, height: view.frameHeight - self.view.safeAreaInsets.bottom - fitViewHeight(62) - tabbar.frameBottom - fitViewHeight(40))
//        vipView.view.frameSize = CGSize(width: view.frameWidth, height: view.frameHeight - self.view.safeAreaInsets.bottom - fitViewHeight(62) - tabbar.frameBottom - fitViewHeight(40))
        collectView.view.frameSize = CGSize(width: view.frameWidth, height: view.frameHeight - self.view.safeAreaInsets.bottom - fitViewHeight(62) - tabbar.frameBottom - fitViewHeight(40))
        freeView.view.frameTop = tabbar.frameBottom + fitViewHeight(10)
//        vipView.view.frameTop = tabbar.frameBottom + fitViewHeight(10)
        collectView.view.frameTop = tabbar.frameBottom + fitViewHeight(10)
    }
    
    lazy var tabbar: AddressPressListSwitchView = {
        let tabbar = AddressPressListSwitchView()
        tabbar.switchType = .free
        tabbar.viewBlock = {[weak self] select in
            UIView.animate(withDuration: 5) {
                if select == .free {
                    self?.freeView.view.isHidden = false
//                    self?.vipView.view.isHidden = true
                    self?.collectView.view.isHidden = true
                    self?.freeView.viewWillAppear(true)
                } else if select == .vip {
                    self?.freeView.view.isHidden = true
//                    self?.vipView.view.isHidden = false
                    self?.collectView.view.isHidden = true
//                    self?.vipView.viewWillAppear(true)
                } else {
                    self?.freeView.view.isHidden = true
//                    self?.vipView.view.isHidden = true
                    self?.collectView.view.isHidden = false
                    self?.collectView.viewWillAppear(true)
                }
            }
        }
        return tabbar
    }()
    
    lazy var freeView: AddressPressListFreeViewController = {
        let resultView = AddressPressListFreeViewController()
        resultView.view.isHidden = false
        return resultView
    }()
    
//    lazy var vipView: AddressPressListVIPViewController = {
//        let resultView = AddressPressListVIPViewController()
//        resultView.view.isHidden = true
//        return resultView
//    }()
    
    lazy var collectView: AddressPressListCollectViewController = {
        let resultView = AddressPressListCollectViewController()
        resultView.view.isHidden = true
        return resultView
    }()
    
    lazy var headerView: PressListHeaderView = {
        let resultView = PressListHeaderView()
        resultView.leftViewBlock = { [weak self] in
            let viewController = ConnectHistoryListViewController()
            self?.navigationController?.pushViewController(viewController, animated: true)
        }
        resultView.rightViewBlock = {
            // 判断连接状态
            if NetworkManager.shared.status == .connected {
                self.showButtonAlert_2(title: "Refresh", message: "Before refreshing, the connection must be disconnected", leftButtonTitle: "Cancel", rightButtonTitle: "Refresh") {
                    
                } rightButtonAction: {[weak self] in
                    RequestManager.shared.updatePing { [weak self] in
                        self?.freeView.tableView.reloadData()
                        self?.collectView.tableView.reloadData()
                    }
                }
            } else {
                // 直接刷新
                RequestManager.shared.updatePing { [weak self] in
                    self?.freeView.tableView.reloadData()
                    self?.collectView.tableView.reloadData()
                }
            }
            self.freeView.tableView.reloadData()
            self.collectView.tableView.reloadData()
        }
        return resultView
    }()
    
}


