//
//  ViewController.swift
//  Youtube
//
//  Created by Ashwini shalke on 06/02/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    let video : [Video] = {
        let selenaVideo = Video()
        selenaVideo.thumbNailImage = "selena=gomez-backgroundImage"
        selenaVideo.title = "selena=gomez"
        
        return [selenaVideo]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        navigationItem.title = "Home"
        navigationController?.navigationBar.isTranslucent = false
        
        //get rid of  border line of navigation bar
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        let barLabel = UILabel()
        barLabel.text = "Home"
        barLabel.font = UIFont.systemFont(ofSize: 20)
        
        barLabel.textColor = UIColor.white
        barLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height)
        navigationItem.titleView = barLabel
        
        collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
        collectionView.backgroundColor = UIColor.white
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
         
        view.addSubview(menuBar)
        view.addConstraintswithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintswithFormat(format: "V:|[v0(50)]", views: menuBar)
    }
    
    

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return video.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
        cell.video = video[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 16 - 16) * 9/16
        return CGSize(width: view.frame.width, height: height + 16 + 68)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}





