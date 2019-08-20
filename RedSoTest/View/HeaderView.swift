//
//  HeaderView.swift
//  RedSoTest
//
//  Created by letao_IOS_2 on 2019/8/13.
//  Copyright © 2019 李泳逸. All rights reserved.
//

import UIKit

protocol HeaderViewDelegate: AnyObject{
    func checkIndex(index: Int)
    func downloadRangersData()
    func downloadElasticData()
    func downloadDynamoData()
}

class HeaderView: UIView {
    weak var delegate: HeaderViewDelegate?
    let rangersBtn = UIButton()
    let elasticBtn = UIButton()
    let dynamoBtn = UIButton()
    let leftUnderLineView = UIView()
    let centerUnderLineView = UIView()
    let rightUnderLineView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black
        
        self.addSubview(rangersBtn)
        NSLayoutConstraint(item: rangersBtn, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: rangersBtn, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 5).isActive = true
        NSLayoutConstraint(item: rangersBtn, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.333, constant: 0).isActive = true
        NSLayoutConstraint(item: rangersBtn, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 45).isActive = true
        rangersBtn.setTitle("Rangers", for: .normal)
        rangersBtn.contentHorizontalAlignment = .center
        rangersBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        rangersBtn.addTarget(self, action: #selector(downloadRangersData), for: .touchUpInside)
        rangersBtn.setTitleColor(.white, for: .normal)
        rangersBtn.translatesAutoresizingMaskIntoConstraints = false
        
        rangersBtn.addSubview(leftUnderLineView)
        NSLayoutConstraint(item: leftUnderLineView, attribute: .centerX, relatedBy: .equal, toItem: rangersBtn, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: leftUnderLineView, attribute: .bottom, relatedBy: .equal, toItem: rangersBtn, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: leftUnderLineView, attribute: .width, relatedBy: .equal, toItem: rangersBtn, attribute: .width, multiplier: 0.8, constant: 0).isActive = true
        NSLayoutConstraint(item: leftUnderLineView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 2).isActive = true
        leftUnderLineView.backgroundColor = UIColor.orange
        leftUnderLineView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(elasticBtn)
        NSLayoutConstraint(item: elasticBtn, attribute: .leading, relatedBy: .equal, toItem: rangersBtn, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: elasticBtn, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 5).isActive = true
        NSLayoutConstraint(item: elasticBtn, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.333, constant: 0).isActive = true
        NSLayoutConstraint(item: elasticBtn, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 45).isActive = true
        elasticBtn.setTitle("Elastic", for: .normal)
        elasticBtn.contentHorizontalAlignment = .center
        elasticBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        elasticBtn.addTarget(self, action: #selector(downloadElasticData), for: .touchUpInside)
        elasticBtn.setTitleColor(.white, for: .normal)
        elasticBtn.translatesAutoresizingMaskIntoConstraints = false
        
        elasticBtn.addSubview(centerUnderLineView)
        NSLayoutConstraint(item: centerUnderLineView, attribute: .centerX, relatedBy: .equal, toItem: elasticBtn, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: centerUnderLineView, attribute: .bottom, relatedBy: .equal, toItem: elasticBtn, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: centerUnderLineView, attribute: .width, relatedBy: .equal, toItem: elasticBtn, attribute: .width, multiplier: 0.8, constant: 0).isActive = true
        NSLayoutConstraint(item: centerUnderLineView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 2).isActive = true
        centerUnderLineView.backgroundColor = UIColor.orange
        centerUnderLineView.isHidden = true
        centerUnderLineView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(dynamoBtn)
        NSLayoutConstraint(item: dynamoBtn, attribute: .leading, relatedBy: .equal, toItem: elasticBtn, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: dynamoBtn, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 5).isActive = true
        NSLayoutConstraint(item: dynamoBtn, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.333, constant: 0).isActive = true
        NSLayoutConstraint(item: dynamoBtn, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 45).isActive = true
        dynamoBtn.setTitle("Dynamo", for: .normal)
        dynamoBtn.contentHorizontalAlignment = .center
        dynamoBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        dynamoBtn.addTarget(self, action: #selector(downloadDynamoData), for: .touchUpInside)
        dynamoBtn.setTitleColor(.white, for: .normal)
        dynamoBtn.translatesAutoresizingMaskIntoConstraints = false
        
        dynamoBtn.addSubview(rightUnderLineView)
        NSLayoutConstraint(item: rightUnderLineView, attribute: .centerX, relatedBy: .equal, toItem: dynamoBtn, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: rightUnderLineView, attribute: .bottom, relatedBy: .equal, toItem: dynamoBtn, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: rightUnderLineView, attribute: .width, relatedBy: .equal, toItem: dynamoBtn, attribute: .width, multiplier: 0.8, constant: 0).isActive = true
        NSLayoutConstraint(item: rightUnderLineView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 2).isActive = true
        rightUnderLineView.backgroundColor = UIColor.orange
        rightUnderLineView.isHidden = true
        rightUnderLineView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc func downloadRangersData(){
        delegate?.checkIndex(index: 0)
        delegate?.downloadRangersData()
        leftUnderLineView.isHidden = false
        centerUnderLineView.isHidden = true
        rightUnderLineView.isHidden = true
    }
    
    @objc func downloadElasticData(){
        delegate?.checkIndex(index: 1)
        delegate?.downloadElasticData()
        leftUnderLineView.isHidden = true
        centerUnderLineView.isHidden = false
        rightUnderLineView.isHidden = true
    }
    
    @objc func downloadDynamoData(){
        delegate?.checkIndex(index: 2)
        delegate?.downloadDynamoData()
        leftUnderLineView.isHidden = true
        centerUnderLineView.isHidden = true
        rightUnderLineView.isHidden = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
   
}
