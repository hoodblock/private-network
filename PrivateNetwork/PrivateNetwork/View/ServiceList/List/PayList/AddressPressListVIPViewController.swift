//
//  AddressPressListVIPViewController.swift
//  PrivateNetwork
//
//  Created by Thomas on 2024/9/19.
//

import UIKit


class AddressPressListVIPViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTableView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func updateTableView() {
        DispatchQueue.main.async {[weak self] in
            self?.regionItems = RequestManager.shared.regionItems.filter( {$0.regionIsVIP == true})
            self?.tableView.reloadData()
        }
    }
    
    lazy var tableView: UITableView = {
        let resultView = UITableView()
        resultView.register(AddressPressItemCell.self, forCellReuseIdentifier: "AddressPressItemCell")
        resultView.delegate = self
        resultView.dataSource = self
        resultView.backgroundColor = UIColor.clear
        resultView.separatorStyle = .none
        return resultView
    }()
    
    lazy var regionItems: [RegionItem] = {
        return RequestManager.shared.regionItems.filter( {$0.regionIsVIP == true})
    }()
}

extension AddressPressListVIPViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return regionItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AddressPressItemCell = tableView.dequeueReusableCell(withIdentifier: "AddressPressItemCell", for: indexPath) as! AddressPressItemCell
        cell.backgroundColor = UIColor.clear
        cell.currentType = .vip
        cell.updateModel(regionItems[indexPath.row])
        cell.selectionStyle = .none
        cell.updateCollectCellBlocK = {[weak self] item in
            item.regioncCollected.toggle()
            self?.updateTableView()
        }
        cell.addressCellClickBlocK = {[weak self] item in
            for item in RequestManager.shared.regionItems {
                item.regionSelected = false
            }
            item.regionSelected.toggle()
            self?.updateTableView()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return fitViewHeight(80)
    }
}
