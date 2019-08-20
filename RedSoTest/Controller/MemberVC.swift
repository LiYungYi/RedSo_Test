//
//  ViewController.swift
//  RedBeardTest
//
//  Created by letao_IOS_2 on 2019/8/13.
//  Copyright © 2019 李泳逸. All rights reserved.
//

import UIKit

class MemberVC: UIViewController, UITableViewDelegate, UITableViewDataSource, HeaderViewDelegate {
    
    let tableView = UITableView()
    let refresher = UIRefreshControl()
    var headerView: HeaderView! = HeaderView()
    var loadingView: LoadingView! = LoadingView()
    
    var rangerData: commonData!
    var rangerDatas = [commonData]()
    var elasticData: commonData!
    var elasticDatas = [commonData]()
    var dynamoData: commonData!
    var dynamoDatas = [commonData]()
    
    var selectedIndex = 0
    var continueLoading = false
    var pageIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        initSubView()
        downloadRangersData()
        headerView.delegate = self
        navigationItem.title = "RedSo"
        navigationController?.navigationBar.barTintColor = UIColor.black
    }
    
    deinit {
        headerView = nil
        loadingView = nil
    }

    func downloadRangersData(){
        APIService.shared.downloadJsonDataFromServer(urlString: "https://us-central1-redso-challenge.cloudfunctions.net", parameter: "/catalog?team=rangers&page=1", handler: downloadRangersDataHandler)
        loadingView = LoadingView(frame: self.view.frame)
        self.view.addSubview(loadingView)
        continueLoading = false
    }

    func downloadRangersDataHandler(data: Data?){
        let dic = APIService.shared.serializeJsonData(data: data)
        guard let results = dic["results"] as? [[String: Any]] else{
            loadingView?.removeFromSuperview()
            loadingView = nil
            return
        }
        if continueLoading == false{
            rangerDatas = []
        }
        for result in results{
            rangerData = commonData(with: result)
            rangerDatas.append(rangerData)
        }
        DispatchQueue.main.async {
            self.loadingView?.removeFromSuperview()
            self.loadingView = nil
            self.tableView.reloadData()
        }
        continueLoading = false
    }
    
    func downloadElasticData(){
        APIService.shared.downloadJsonDataFromServer(urlString: "https://us-central1-redso-challenge.cloudfunctions.net", parameter: "/catalog?team=elastic&page=1", handler: downloadElasticDataHandler)
        loadingView = LoadingView(frame: self.view.frame)
        self.view.addSubview(loadingView)
        continueLoading = false
    }
    
    func downloadElasticDataHandler(data: Data?){
        let dic = APIService.shared.serializeJsonData(data: data)
        guard let results = dic["results"] as? [[String: Any]] else{
            loadingView?.removeFromSuperview()
            loadingView = nil
            return
        }
        if continueLoading == false{
            elasticDatas = []
        }
        for result in results{
            elasticData = commonData(with: result)
            elasticDatas.append(elasticData)
        }
        DispatchQueue.main.async {
            self.loadingView?.removeFromSuperview()
            self.loadingView = nil
            self.tableView.reloadData()
        }
    }
    
    func downloadDynamoData(){
        APIService.shared.downloadJsonDataFromServer(urlString: "https://us-central1-redso-challenge.cloudfunctions.net", parameter: "/catalog?team=dynamo&page=1", handler: downloadDynamoDataHandler)
        loadingView = LoadingView(frame: self.view.frame)
        self.view.addSubview(loadingView)
        continueLoading = false
    }
    
    func downloadDynamoDataHandler(data: Data?){
        let dic = APIService.shared.serializeJsonData(data: data)
        guard let results = dic["results"] as? [[String: Any]] else{
            loadingView?.removeFromSuperview()
            loadingView = nil
            return
        }
        if continueLoading == false{
            dynamoDatas = []
        }
        for result in results{
            dynamoData = commonData(with: result)
            dynamoDatas.append(dynamoData)
        }
        DispatchQueue.main.async {
            self.loadingView?.removeFromSuperview()
            self.loadingView = nil
            self.tableView.reloadData()
        }
    }
    
    func checkIndex(index: Int){
        selectedIndex = index
    }
    
    @objc func refreshData(){
        if selectedIndex == 0{
            continueLoading = false
            downloadRangersData()
        }else if selectedIndex == 1{
            continueLoading = false
            downloadElasticData()
        }else{
            continueLoading = false
            downloadDynamoData()
        }
        refresher.endRefreshing()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedIndex == 0{
            return rangerDatas.count
        }else if selectedIndex == 1{
            return elasticDatas.count
        }else{
            return dynamoDatas.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommonCell", for: indexPath) as! CommonTableViewCell
        if selectedIndex == 0{
            if rangerDatas.count != 0{
                cell.updateView(data: rangerDatas[indexPath.row])
            }
            return cell
        }else if selectedIndex == 1{
            if elasticDatas.count != 0{
                cell.updateView(data: elasticDatas[indexPath.row])
            }
            return cell
        }else{
            if dynamoDatas.count != 0{
                cell.updateView(data: dynamoDatas[indexPath.row])
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if selectedIndex == 0{
            let lastItem = rangerDatas.count - 1
            if indexPath.row == lastItem{
                let pageIndex = indexPath.row / 3 + 1
                let lastIndex = IndexPath(row: lastItem, section: 0)
                if indexPath == lastIndex{
                    if (indexPath.row + 1) % 4 != 0{
                        return
                    }else{
                        continueLoading = true
                        APIService.shared.downloadJsonDataFromServer(urlString: "https://us-central1-redso-challenge.cloudfunctions.net", parameter: "/catalog?team=rangers&page=\(pageIndex)", handler: downloadRangersDataHandler)
                    }
                }
            }
        }else if selectedIndex == 1{
            let lastItem = elasticDatas.count - 1
            if indexPath.row == lastItem{
                let pageIndex = indexPath.row / 3 + 1
                let lastIndex = IndexPath(row: lastItem, section: 0)
                if indexPath == lastIndex{
                    if (indexPath.row + 1) % 4 != 0{
                        return
                    }else{
                        continueLoading = true
                        APIService.shared.downloadJsonDataFromServer(urlString: "https://us-central1-redso-challenge.cloudfunctions.net", parameter: "/catalog?team=elastic&page=\(pageIndex)", handler: downloadElasticDataHandler)
                    }
                }
            }
        }else{
            let lastItem = dynamoDatas.count - 1
            if indexPath.row == lastItem{
                let pageIndex = indexPath.row / 3 + 1
                let lastIndex = IndexPath(row: lastItem, section: 0)
                if indexPath == lastIndex{
                    if (indexPath.row + 1) % 4 != 0{
                        return
                    }else{
                        continueLoading = true
                        APIService.shared.downloadJsonDataFromServer(urlString: "https://us-central1-redso-challenge.cloudfunctions.net", parameter: "/catalog?team=dynamo&page=\(pageIndex)", handler: downloadDynamoDataHandler)
                    }
                }
            }
        }
    }
    
    func initSubView(){
        self.view.addSubview(tableView)
        NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: tableView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: tableView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.black
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.register(CommonTableViewCell.self, forCellReuseIdentifier: "CommonCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        refresher.addTarget(self, action: #selector(refreshData), for: UIControl.Event.valueChanged)
        tableView.addSubview(refresher)
    }
    
}

