//
//  RangersTableViewCell.swift
//  RedSoTest
//
//  Created by letao_IOS_2 on 2019/8/13.
//  Copyright © 2019 李泳逸. All rights reserved.
//

import UIKit

class CommonTableViewCell: UITableViewCell {
    let photoImageView = UIImageView()
    let backgroundImageView = UIImageView()
    let nameLabel = UILabel()
    let positionLabel = UILabel()
    let experienceLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.black
        
        self.addSubview(photoImageView)
        NSLayoutConstraint(item: photoImageView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 10).isActive = true
        NSLayoutConstraint(item: photoImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: photoImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100).isActive = true
        NSLayoutConstraint(item: photoImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100).isActive = true
        photoImageView.contentMode = .scaleAspectFit
        photoImageView.layer.cornerRadius = 50
        photoImageView.clipsToBounds = true
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(backgroundImageView)
        NSLayoutConstraint(item: backgroundImageView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: backgroundImageView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: backgroundImageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: backgroundImageView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        backgroundImageView.contentMode = .scaleToFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(positionLabel)
        NSLayoutConstraint(item: positionLabel, attribute: .leading, relatedBy: .equal, toItem: photoImageView, attribute: .trailing, multiplier: 1.0, constant: 10).isActive = true
        NSLayoutConstraint(item: positionLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: positionLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -10).isActive = true
        positionLabel.textColor = UIColor.white
        positionLabel.lineBreakMode = .byWordWrapping
        positionLabel.numberOfLines = 0
        positionLabel.font = UIFont.boldSystemFont(ofSize: 14)
        positionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(nameLabel)
        NSLayoutConstraint(item: nameLabel, attribute: .leading, relatedBy: .equal, toItem: photoImageView, attribute: .trailing, multiplier: 1.0, constant: 10).isActive = true
        NSLayoutConstraint(item: nameLabel, attribute: .bottom, relatedBy: .equal, toItem: positionLabel, attribute: .top, multiplier: 1.0, constant: -20).isActive = true
        NSLayoutConstraint(item: nameLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -10).isActive = true
        nameLabel.textColor = UIColor.white
        nameLabel.lineBreakMode = .byWordWrapping
        nameLabel.numberOfLines = 0
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(experienceLabel)
        NSLayoutConstraint(item: experienceLabel, attribute: .leading, relatedBy: .equal, toItem: photoImageView, attribute: .trailing, multiplier: 1.0, constant: 10).isActive = true
        NSLayoutConstraint(item: experienceLabel, attribute: .top, relatedBy: .equal, toItem: positionLabel, attribute: .bottom, multiplier: 1.0, constant: 20).isActive = true
        NSLayoutConstraint(item: experienceLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -10).isActive = true
        experienceLabel.textColor = UIColor.white
        experienceLabel.lineBreakMode = .byWordWrapping
        experienceLabel.numberOfLines = 0
        experienceLabel.font = UIFont.boldSystemFont(ofSize: 14)
        experienceLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func updateView(data: commonData){
        nameLabel.text = data.name
        positionLabel.text = data.position
        var experience = ""
        if data.expertise.count != 0{
            for ex in data.expertise{
                if let last = data.expertise.last{
                    if data.expertise.count != 1 && ex != last{
                        experience = experience + ex + ", "
                    }else{
                        experience = experience + ex
                    }
                }
            }
        }
        experienceLabel.text = experience
        DispatchQueue.global().async {
            if data.avatar != ""{
                self.downloadImage(avatar: data.avatar, imageURL: URL(string: data.avatar))
            }else{
                self.downloadImage(avatar: data.avatar, imageURL: URL(string: data.url))
            }
        }
    }
    
    func downloadImage(avatar: String, imageURL: URL?){
        if avatar != ""{
            if let imageURL = imageURL{
                do{
                    if let image = UIImage(data: try Data(contentsOf: imageURL)) {
                        DispatchQueue.main.async{
                            self.photoImageView.isHidden = false
                            self.photoImageView.image = image
                            self.backgroundImageView.isHidden = true
                        }
                    }
                }catch{
                    DispatchQueue.main.async {
                        self.photoImageView.isHidden = false
                        self.photoImageView.image = UIImage(named: "error")
                        self.backgroundImageView.isHidden = true
                    }
                }
            }else{
                DispatchQueue.main.async {
                    self.photoImageView.isHidden = false
                    self.photoImageView.image = UIImage(named: "error")
                    self.backgroundImageView.isHidden = true
                }
            }
        }else{
            if let imageURL = imageURL{
                do{
                    if let image = UIImage(data: try Data(contentsOf: imageURL)) {
                        DispatchQueue.main.async{
                            self.photoImageView.isHidden = true
                            self.backgroundImageView.isHidden = false
                            self.backgroundImageView.image = image
                        }
                    }
                }catch{
                    DispatchQueue.main.async {
                        self.photoImageView.isHidden = true
                        self.backgroundImageView.isHidden = false
                        self.backgroundImageView.image = UIImage(named: "error")
                    }
                }
            }else{
                DispatchQueue.main.async {
                    self.photoImageView.isHidden = true
                    self.backgroundImageView.isHidden = false
                    self.backgroundImageView.image = UIImage(named: "error")
                }
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
