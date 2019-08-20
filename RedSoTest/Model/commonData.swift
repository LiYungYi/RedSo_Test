//
//  RangersData.swift
//  RedSoTest
//
//  Created by letao_IOS_2 on 2019/8/13.
//  Copyright © 2019 李泳逸. All rights reserved.
//

import Foundation

struct commonData {
    var id = ""
    var name = ""
    var position = ""
    var expertise = [String]()
    var avatar = ""

    var type = ""
    var url = ""
    
    init(with dic: [String: Any]) {
        if let id = dic["id"] as? String,
            let name = dic["name"] as? String,
            let position = dic["position"] as? String,
            let expertise = dic["expertise"] as? [String],
            let avatar = dic["avatar"] as? String{
            
            self.id = id
            self.name = name
            self.position = position
            self.expertise = expertise
            self.avatar = avatar
        }
        
        if let type = dic["type"] as? String,
            let url = dic["url"] as? String{
            
            self.type = type
            self.url = url
        }
    }
    
}
