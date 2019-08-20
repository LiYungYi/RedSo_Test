//
//  APIService.swift
//  MondayTest
//
//  Created by letao_IOS_2 on 2019/8/13.
//  Copyright © 2019 李泳逸. All rights reserved.
//

import Foundation
import UIKit

class APIService: NSObject, URLSessionDelegate{
    static let shared = APIService()
    
    func downloadJsonDataFromServer(urlString: String, parameter: String, handler: @escaping(_: Data?)->()){
        
        if let url = URL(string: urlString + parameter){
            var request = URLRequest(url: url)
            let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
            request.timeoutInterval = 30
            
            let task = session.dataTask(with: request) { (data, response, error) in
                if let error = error{
                    popAlert("下載失敗", message: error.localizedDescription)
                    return
                }else{
                    handler(data)
                }
            }
            task.resume()
        }
    }
    
    func serializeJsonData(data: Data?, errorHandler: @escaping ()->() = {}) -> [String: Any]{
        if let data = data{
            do {
                if let dataDic = try JSONSerialization.jsonObject(with: data) as? [String: Any]{
                    return dataDic
                }else{
                    popAlert("資料格式有誤")
                    return ["":""]
                }
            }catch{
                guard let dataBody = String(data: data, encoding: .utf8) else{
                    return ["":""]
                }
                print(dataBody)
                popAlert("資料解析錯誤")
                return ["":""]
            }
        }else{
            errorHandler()
            return ["":""]
        }
    }
}

func popAlert(_ title: String, message: String? = nil, cancelHandler: @escaping ()->() = {}){
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "確定", style: .default, handler: { _ in
        cancelHandler()
    }))
    if var topVC = UIApplication.shared.keyWindow?.rootViewController{
        while let nextVC = topVC.presentedViewController{
            topVC = nextVC
        }
        DispatchQueue.main.async {
            topVC.present(alert, animated: true, completion: nil)
        }
    }
}
