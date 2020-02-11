//
//  ViewCell.swift
//  Youtube
//
//  Created by Ashwini shalke on 10/02/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit

class BaseCell : UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup(){}
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class VideoCell: BaseCell {
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "selena=gomez-backgroundImage")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let profileImageView: UIImageView = {
        let profile = UIImageView()
        profile.image = UIImage(named: "selena-gomez-profile")
        profile.contentMode = .scaleAspectFill
        profile.layer.cornerRadius = 22
        profile.clipsToBounds = true
        return profile
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Selena-Gomez - Blank Space"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let titleDescription: UITextView = {
        let label = UITextView()
        label.text = "SelenaGomez - 1,234,678 views -2 years ago"
        label.textColor = UIColor.gray
        label.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let separator: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return line
    }()
    
    
    override func setup(){
        super.setup()
        addSubview(thumbnailImageView)
        addSubview(separator)
        addSubview(profileImageView)
        addSubview(titleLabel)
        addSubview(titleDescription)
        
        addConstraintswithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
        addConstraintswithFormat(format: "H:|-16-[v0(44)]", views: profileImageView)
        addConstraintswithFormat(format: "V:|-16-[v0]-8-[v1(44)]-16-[v2(1)]|" , views: thumbnailImageView,profileImageView,separator)
        addConstraintswithFormat(format: "H:|[v0]|", views: separator)
        
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom , multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: profileImageView, attribute: .right , multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right , multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height , multiplier: 0, constant: 20))
        
        
        addConstraint(NSLayoutConstraint(item: titleDescription, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom , multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: titleDescription, attribute: .left, relatedBy: .equal, toItem: profileImageView, attribute: .right , multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: titleDescription, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right , multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: titleDescription, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height , multiplier: 0, constant: 20))
        
    }
}

