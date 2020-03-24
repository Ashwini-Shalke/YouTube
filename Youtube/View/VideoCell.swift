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
    var video: Video? {
        didSet {
            titleLabel.text = video?.title
            setupThumbnailImage()
            setupProfileImage()
            if let channelName = video?.channel?.name, let numberofViews = video?.numberOfViews {
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                titleDescription.text = "\(channelName) • \(numberFormatter.string(from: NSNumber(value: numberofViews))!) views • 2 years ago"
            }
            if let title = video?.title {
                let size = CGSize(width: frame.width - 16 - 44 - 8 - 16 , height: 10000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], context: nil)
                if estimatedRect.size.height > 20 {
                    titleLabelHeightConstraint?.constant = 44
                }else {
                    titleLabelHeightConstraint?.constant = 30
                }
            }
        }
    }
    
    func setupProfileImage(){
        if let profileImageURL = video?.channel?.profileImageName {
            self.profileImageView.loadImagewithURL(urlString: profileImageURL)
        }
    }
    
    func setupThumbnailImage(){
        if let thumbnailImageURL = video?.thumbnailImage {
            self.thumbnailImageView.loadImagewithURL(urlString: thumbnailImageURL)
        }
    }
    
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        //imageView.image = UIImage(named: "selena=gomez-backgroundImage")
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
        profile.contentMode = .scaleAspectFill
        return profile
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Selena-Gomez - Blank Space"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var titleLabelHeightConstraint : NSLayoutConstraint?
    
    let titleDescription: UITextView = {
        let label = UITextView()
        label.text = "SelenaGomez • 1,234,678 views • 2 years ago"
        label.isEditable = false
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
        
        titleLabelHeightConstraint = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height , multiplier: 0, constant: 44)
        addConstraint(titleLabelHeightConstraint!)
        
        
        addConstraint(NSLayoutConstraint(item: titleDescription, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom , multiplier: 1, constant: 4    ))
        addConstraint(NSLayoutConstraint(item: titleDescription, attribute: .left, relatedBy: .equal, toItem: profileImageView, attribute: .right , multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: titleDescription, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right , multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: titleDescription, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height , multiplier: 0, constant: 30))
        
    }
}

