//
//  AppDelegate.swift
//  PrivateNetwork
//
//  Created by Thomas on 2024/7/16.
//

import UIKit
import AppTrackingTransparency


//
typealias ViewBlock = () -> (Void)

// heiwhfe
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        RequestManager.shared.fetchRegionDetail {
            RequestManager.shared.fetchRegionList {
            } failure: {
            }
        } failure: {
            RequestManager.shared.fetchRegionList {
            } failure: {
            }
        }
        if UserDefaults.standard.string(forKey: "V_608_DOWNLOAD_APP")?.count ?? 0 > 0 {
            pressAnimationView()
        } else {
            UserDefaults.standard.setValue("V_608_DOWNLOAD_APP", forKey: "V_608_DOWNLOAD_APP")
            UserDefaults.standard.synchronize()
            downloadAppNetAuthorization()
        }
        _ = HistoryManager.shared
        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // 延迟一秒钟后请求跟踪授权
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {[weak self] in
            self?.requestTrackingAuthorization()
        }
        // 动画
//        if UserDefaults.standard.string(forKey: "V_608_DOWNLOAD_APP")?.count ?? 0 > 0 {
//            pressAnimationView()
//        }
    }
    
    lazy var tabbarView: ConnectMainTabbarController = {
        let resultView = ConnectMainTabbarController()
        resultView.navigationController?.navigationBar.barStyle = .default
        return resultView
    }()
}



extension AppDelegate {
    
    private func requestTrackingAuthorization() {
        // 确保 AppTrackingTransparency 框架已导入，并且 iOS 14.0 及以上版本支持
        if #available(iOS 14.0, *) {
            ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
            })
        }
    }
}


// 页面
extension AppDelegate {
 
    // 下载授权
    private func downloadAppNetAuthorization() {
        let viewController = StartHanderViewController()
        viewController.viewBlock = {[weak self] in
            self?.pressAnimationView()
        }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
    
    // 进度动画页面
    private func pressAnimationView() {
        if let vc = window?.rootViewController {
            if vc is AnimationLaunchScreenViewController {
                return
            } else {
                let viewController = AnimationLaunchScreenViewController()
                viewController.viewBlock = {[weak self] in
                    self?.toConnectView()
                }
                window = UIWindow(frame: UIScreen.main.bounds)
                window?.rootViewController = viewController
                window?.makeKeyAndVisible()
            }
        } else {
            let viewController = AnimationLaunchScreenViewController()
            viewController.viewBlock = {[weak self] in
                self?.toConnectView()
            }
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.rootViewController = viewController
            window?.makeKeyAndVisible()
        }
    }
    
    // 首页
    func toConnectView() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: tabbarView)
        window?.makeKeyAndVisible()
    }
}
