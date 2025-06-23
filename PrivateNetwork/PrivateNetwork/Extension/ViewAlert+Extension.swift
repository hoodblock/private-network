//
//  ViewAlert+Extension.swift
//  PrivateNetwork
//
//  Created by Thomas on 2024/11/11.
//


import UIKit


extension UIViewController {
    
    /// 时间弹窗
    func showAddTimeAlert(buttonAction: @escaping () -> Void) {
        if alertIsShowing() {
            return
        }
        let alertView = ShowTimerAlertView()
        alertView.clickBlock = { [weak self] in
            self?.dismissAlert()
            buttonAction()
        }
        
        alertView.translatesAutoresizingMaskIntoConstraints = false
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        // 点击背景关闭弹窗
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissAlert))
        backgroundView.addGestureRecognizer(tapGesture)
        
        if let topController = UIApplication.shared.windows.first?.rootViewController?.topViewController {
            topController.view.addSubview(backgroundView)
            topController.view.addSubview(alertView)
            NSLayoutConstraint.activate([
                backgroundView.leadingAnchor.constraint(equalTo: topController.view.leadingAnchor),
                backgroundView.trailingAnchor.constraint(equalTo: topController.view.trailingAnchor),
                backgroundView.topAnchor.constraint(equalTo: topController.view.topAnchor),
                backgroundView.bottomAnchor.constraint(equalTo: topController.view.bottomAnchor),

                alertView.centerXAnchor.constraint(equalTo: topController.view.centerXAnchor),
                alertView.centerYAnchor.constraint(equalTo: topController.view.centerYAnchor),
                alertView.widthAnchor.constraint(equalToConstant: 300),
                alertView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200)
            ])
        }
    }
    
    ///  添加时间弹窗
    func showTimeStatusAlert(buttonAction: @escaping () -> Void) {
        if alertIsShowing() {
            return
        }
        let alertView = ShowTimerStatusAlertView()
        alertView.clickBlock = { [weak self] in
            self?.dismissAlert()
            buttonAction()
        }
        
        alertView.translatesAutoresizingMaskIntoConstraints = false
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        // 点击背景关闭弹窗
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissAlert))
        backgroundView.addGestureRecognizer(tapGesture)
        
        if let topController = UIApplication.shared.windows.first?.rootViewController?.topViewController {
            topController.view.addSubview(backgroundView)
            topController.view.addSubview(alertView)
            NSLayoutConstraint.activate([
                backgroundView.leadingAnchor.constraint(equalTo: topController.view.leadingAnchor),
                backgroundView.trailingAnchor.constraint(equalTo: topController.view.trailingAnchor),
                backgroundView.topAnchor.constraint(equalTo: topController.view.topAnchor),
                backgroundView.bottomAnchor.constraint(equalTo: topController.view.bottomAnchor),

                alertView.centerXAnchor.constraint(equalTo: topController.view.centerXAnchor),
                alertView.centerYAnchor.constraint(equalTo: topController.view.centerYAnchor),
                alertView.widthAnchor.constraint(equalToConstant: 300),
                alertView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200)
            ])
        }
    }
    
    /// 动画弹窗
    func showAnimationAlert(title: String, buttonAction: @escaping () -> Void) {
        if alertIsShowing() {
            return
        }
        let alertView = ShowAnimationView()
        alertView.updateTitle(title: title)
        alertView.translatesAutoresizingMaskIntoConstraints = false
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
 
        if let topController = UIApplication.shared.windows.first?.rootViewController?.topViewController {
            topController.view.addSubview(backgroundView)
            topController.view.addSubview(alertView)
            NSLayoutConstraint.activate([
                backgroundView.leadingAnchor.constraint(equalTo: topController.view.leadingAnchor),
                backgroundView.trailingAnchor.constraint(equalTo: topController.view.trailingAnchor),
                backgroundView.topAnchor.constraint(equalTo: topController.view.topAnchor),
                backgroundView.bottomAnchor.constraint(equalTo: topController.view.bottomAnchor),

                alertView.centerXAnchor.constraint(equalTo: topController.view.centerXAnchor),
                alertView.centerYAnchor.constraint(equalTo: topController.view.centerYAnchor),
                alertView.widthAnchor.constraint(equalToConstant: 300),
                alertView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200)
            ])
        }
    }
    
    /// 单按钮提示弹窗
    func showButtonAlert_1(title: String, message: String, buttonTitle: String, buttonAction: @escaping () -> Void) {
        if alertIsShowing() {
            return
        }
        let alertView = ShowTipsAlertView()
        alertView.updateTitle(title: title, message: message, buttonTitle: buttonTitle)
        alertView.clickBlock = { [weak self] in
            self?.dismissAlert()
            buttonAction()
        }
        alertView.translatesAutoresizingMaskIntoConstraints = false
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        if let topController = UIApplication.shared.windows.first?.rootViewController?.topViewController {
            topController.view.addSubview(backgroundView)
            topController.view.addSubview(alertView)
            NSLayoutConstraint.activate([
                backgroundView.leadingAnchor.constraint(equalTo: topController.view.leadingAnchor),
                backgroundView.trailingAnchor.constraint(equalTo: topController.view.trailingAnchor),
                backgroundView.topAnchor.constraint(equalTo: topController.view.topAnchor),
                backgroundView.bottomAnchor.constraint(equalTo: topController.view.bottomAnchor),

                alertView.centerXAnchor.constraint(equalTo: topController.view.centerXAnchor),
                alertView.centerYAnchor.constraint(equalTo: topController.view.centerYAnchor),
                alertView.widthAnchor.constraint(equalToConstant: 300),
                alertView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200)
            ])
        }
    }
    
    
    /// 双按钮提示弹窗
    func showButtonAlert_2(title: String, message: String, leftButtonTitle: String, rightButtonTitle: String, leftButtonAction: @escaping () -> Void, rightButtonAction: @escaping () -> Void) {
        if alertIsShowing() {
            return
        }
        let alertView = ShowActionAlertView()
        alertView.updateTitle(title: title, message: message, leftButtonTitle: leftButtonTitle, rightButtonTitle: rightButtonTitle)
        alertView.clickLeftBlock = { [weak self] in
            self?.dismissAlert()
            leftButtonAction()
        }
        alertView.clickRightBlock = { [weak self] in
            self?.dismissAlert()
            rightButtonAction()
        }
        alertView.translatesAutoresizingMaskIntoConstraints = false
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        if let topController = UIApplication.shared.windows.first?.rootViewController?.topViewController {
            topController.view.addSubview(backgroundView)
            topController.view.addSubview(alertView)
            NSLayoutConstraint.activate([
                backgroundView.leadingAnchor.constraint(equalTo: topController.view.leadingAnchor),
                backgroundView.trailingAnchor.constraint(equalTo: topController.view.trailingAnchor),
                backgroundView.topAnchor.constraint(equalTo: topController.view.topAnchor),
                backgroundView.bottomAnchor.constraint(equalTo: topController.view.bottomAnchor),

                alertView.centerXAnchor.constraint(equalTo: topController.view.centerXAnchor),
                alertView.centerYAnchor.constraint(equalTo: topController.view.centerYAnchor),
                alertView.widthAnchor.constraint(equalToConstant: 300),
                alertView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200)
            ])
        }
    }
    
    @objc func dismissAlert() {
        // 查找并移除弹窗和背景视图
        if let topController = UIApplication.shared.windows.first?.rootViewController?.topViewController {
            for subview in topController.view.subviews {
                if let customAlert = subview as? ShowTimerAlertView {
                    customAlert.removeFromSuperview()
                } else if let customAlert = subview as? ShowTimerStatusAlertView {
                    customAlert.removeFromSuperview()
                } else if let customAlert = subview as? ShowAnimationView {
                    customAlert.removeFromSuperview()
                } else if let customAlert = subview as? ShowTipsAlertView {
                    customAlert.removeFromSuperview()
                } else if let customAlert = subview as? ShowActionAlertView {
                    customAlert.removeFromSuperview()
                }
                // 只移除背景视图
                if subview.backgroundColor == UIColor.black.withAlphaComponent(0.8) {
                    subview.removeFromSuperview()
                }
            }
        }
    }
    
    
    private func alertIsShowing() -> Bool {
        // 查找并移除弹窗和背景视图
        if let topController = UIApplication.shared.windows.first?.rootViewController?.topViewController {
            for subview in topController.view.subviews {
                if subview is ShowTimerAlertView {
                    return true
                } else if subview is ShowTimerStatusAlertView {
                    return true
                } else if subview is ShowAnimationView {
                    return true
                } else if subview is ShowTipsAlertView {
                    return true
                } else if subview is ShowActionAlertView {
                    return true
                }
            }
        }
        return false
    }
    
    var topViewController: UIViewController {
        if let presented = self.presentedViewController {
            return presented.topViewController
        } else if let navigation = self as? UINavigationController {
            return navigation.visibleViewController?.topViewController ?? navigation
        } else if let tab = self as? UITabBarController {
            return tab.selectedViewController?.topViewController ?? tab
        } else {
            return self
        }
    }
}
