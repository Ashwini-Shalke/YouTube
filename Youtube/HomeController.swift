//
//  ViewController.swift
//  Youtube
//
//  Created by Ashwini shalke on 06/02/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Home"
        collectionView.backgroundColor = UIColor.white
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


class VideoCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.blue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let profileImageView: UIImageView = {
        let profile = UIImageView()
        profile.backgroundColor = UIColor.orange
        profile.translatesAutoresizingMaskIntoConstraints = false
        profile.layer.cornerRadius = 22
        profile.clipsToBounds = true
        return profile
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let titleDescription: UILabel = {
           let label = UILabel()
        label.backgroundColor = UIColor.red
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }()
    
    let separator: UIView = {
       let line = UIView()
       line.backgroundColor = UIColor.gray
       line.translatesAutoresizingMaskIntoConstraints = false
       return line
    }()
    
    
    func setup(){
        addSubview(thumbnailImageView)
        addSubview(separator)
        addSubview(profileImageView)
        addSubview(titleLabel)
        addSubview(titleDescription)
   
        addConstraintswithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
        addConstraintswithFormat(format: "H:|-16-[v0(44)]", views: profileImageView)
        addConstraintswithFormat(format: "V:|-16-[v0]-8-[v1(44)]-16-[v2(1)]|" , views: thumbnailImageView,profileImageView,separator)
        addConstraintswithFormat(format: "H:|[v0]|" , views: separator)
        
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

extension UIView {
    func addConstraintswithFormat(format: String, views: UIView...){
        var viewDict = [String: UIView]()
        for (index, item) in views.enumerated(){
            let key = "v\(index)"
            viewDict[key] = item
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat:format, options:[], metrics: nil, views: viewDict))
    }
}

