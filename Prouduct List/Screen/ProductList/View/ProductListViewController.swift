//
//  ProductListViewController.swift
//  Prouduct List
//
//  Created by Jakaria Noman on 10/1/25.
//

import UIKit
enum TableViewSection: Int, CaseIterable {
    case defaultInformation
    case productListData
}

class ProductListViewController: UIViewController {
    
    @IBOutlet weak var productTableView: UITableView!
    private var productViewModel = ProductViewModel()
    var isDataLoaded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }
}

extension ProductListViewController {
    func configuration() {
        productTableView.register(UINib(nibName: "DefaultInformationCell", bundle: nil), forCellReuseIdentifier: "defaultInformationCell")
        productTableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
        initViewModel()
        observerEvent()
    }
    
    func initViewModel() {
        productViewModel.fetchProduct()
    }
    
    func observerEvent() {
        productViewModel.eventHandler = { [weak self] event in
            guard let self else { return }
            
            switch event {
            case .loadding :
                print("Start Loading....")
            case .dataLoaded :
                isDataLoaded = true
                DispatchQueue.main.async {
                    self.productTableView.reloadData()
                }
            case .stopLoading :
                print("Stop Loading...")
            case .error(let error):
                print("Error is \(String(describing: error))")
            }
        }
    }
}

extension ProductListViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        TableViewSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // productViewModel.products.count
        if section == 0 {
            return 1
        } else {
            return productViewModel.products.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "defaultInformationCell", for: indexPath) as? DefaultInformationCell else {
                return UITableViewCell()
            }
            cell.dataStartFetch = isDataLoaded ? .showRefreshButton : .showIndicator
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as? ProductCell else {
                return UITableViewCell()
            }
            let newProduct = productViewModel.products[indexPath.row]
            
            cell.newProductObserver = newProduct
            return cell
        }
    }
}
