//
//  ConnectMainTabbarController.swift
//  V608
//
//  Created by Thomas on 2024/9/14.
//

import UIKit


class ConnectMainTabbarController : UIViewController {
    
    var viewBlock: ViewBlock?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        self.addChild(connectView)
        self.addChild(addressView)
        self.addChild(memberView)
        view.addSubview(connectView.view)
        view.addSubview(addressView.view)
        view.addSubview(memberView.view)
        view.addSubview(tabbar)
        tabbar.updateStatus(status: .home)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        connectView.view.frame = view.bounds
        addressView.view.frame = view.bounds
        memberView.view.frame = view.bounds
        tabbar.frameSize = CGSize(width: fitViewHeight(269), height: fitViewHeight(62))
        tabbar.frameCenterX = view.frameCenterX
        tabbar.frameBottom = self.view.frameHeight - self.view.safeAreaInsets.bottom
    }
    
    lazy var tabbar: ConnectMainTabbar = {
        let tabbar = ConnectMainTabbar()
        tabbar.connnectType = .home
        tabbar.viewBlock = {[weak self] select in
            UIView.animate(withDuration: 5) {
                if select == .home {
                    self?.connectView.view.isHidden = false
                    self?.addressView.view.isHidden = true
                    self?.memberView.view.isHidden = true
                    self?.connectView.viewWillAppear(true)
                } else if select == .address {
                    self?.connectView.view.isHidden = true
                    self?.addressView.view.isHidden = false
                    self?.memberView.view.isHidden = true
                    self?.addressView.viewWillAppear(true)
                } else {
                    self?.connectView.view.isHidden = true
                    self?.addressView.view.isHidden = true
                    self?.memberView.view.isHidden = false
                    self?.memberView.viewWillAppear(true)
                }
            }
        }
        return tabbar
    }()
    
    lazy var connectView: ConnectViewController = {
        let resultView = ConnectViewController()
        resultView.view.isHidden = false
        return resultView
    }()
    
    lazy var addressView: AddressPressListViewController = {
        let resultView = AddressPressListViewController()
        resultView.view.isHidden = true
        return resultView
    }()
    
    lazy var memberView: MemberShipViewController = {
        let resultView = MemberShipViewController()
        resultView.view.isHidden = true
        return resultView
    }()
}


