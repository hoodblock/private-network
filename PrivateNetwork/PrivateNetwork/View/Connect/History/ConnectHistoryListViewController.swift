//
//  ConnectHistoryListViewController.swift
//  PrivateNetwork
//
//  Created by Thomas on 2024/9/6.
//

import UIKit


class ConnectHistoryListViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.addSubview(headerView)
        view.addSubview(collectionView)
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
        collectionView.frameSize = CGSize(width: view.frameWidth - fitViewHeight(35) * 2, height: view.frameHeight - headerView.frameBottom - self.view.safeAreaInsets.bottom)
        collectionView.frameTop = headerView.frameBottom
        collectionView.frameCenterX = view.frameWidth / 2
    }
    
    lazy var headerView: TopHeaderView = {
        let resultView = TopHeaderView()
        resultView.updateTitle(title: "Connect History")
        resultView.viewBlock = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        return resultView
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let padding: CGFloat = fitViewHeight(20)  // 设置单元格之间的间距
        let itemWidth = (view.frame.width - fitViewHeight(35) * 2 - padding) / 2
        layout.itemSize = CGSize(width: itemWidth, height: 155 * itemWidth / 140) // 每个 item 的尺寸
        layout.minimumInteritemSpacing = padding // 列间距
        layout.minimumLineSpacing = padding * 1.5 // 行间距
        let resultView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        resultView.translatesAutoresizingMaskIntoConstraints = false
        resultView.showsHorizontalScrollIndicator = false
        resultView.showsVerticalScrollIndicator = false
        resultView.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        resultView.register(ConnnectHistoryCell.self, forCellWithReuseIdentifier: ConnnectHistoryCell.identifier)
        resultView.dataSource = self
        resultView.delegate = self
        return resultView
    }()
  
}

extension ConnectHistoryListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // 数据源方法：返回每个 item 的数量
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return HistoryManager.shared.regionItems.count
    }
    
    // 数据源方法：返回每个 item 的 cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ConnnectHistoryCell.identifier, for: indexPath) as! ConnnectHistoryCell
        cell.configure(item: HistoryManager.shared.regionItems[indexPath.row])
        return cell
    }
    
    // 委托方法：处理点击事件
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = HistoryManager.shared.regionItems[indexPath.row]
    }
    
    // 可选：设置每个 item 的大小（已经在 layout 中配置，不需要重复配置）
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = fitViewHeight(20)
        let itemWidth = (view.frame.width - fitViewHeight(35) * 2 - padding) / 2
        return CGSize(width: itemWidth, height: 155 * itemWidth / 140)
    }
    
}
