//
//  ProductWebViewController.swift
//  V608
//
//  Created by Thomas on 2024/12/4.
//


import UIKit
import WebKit

class ProductWebViewController: UIViewController {

    // 创建一个 WKWebView 属性
    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(headerView)

        // 初始化 WKWebView 配置
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        
        // 设置 webView 的自动布局（auto layout）
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        
        // 加载一个 URL
        if let url = URL(string: "https://fast.com") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        headerView.frameSize = CGSize(width: view.frameWidth, height: fitViewHeight(50))
        headerView.frameTop = self.view.safeAreaInsets.top
        webView.frame = CGRectMake(0, headerView.frameBottom, view.frameWidth, view.frameHeight - headerView.frameBottom - self.view.safeAreaInsets.bottom)
    }
    
    lazy var headerView: TopHeaderView = {
        let resultView = TopHeaderView()
        resultView.updateTitle(title: "Speed")
        resultView.viewBlock = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        return resultView
    }()
}
