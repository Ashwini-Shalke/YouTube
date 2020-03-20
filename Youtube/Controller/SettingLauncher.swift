//
//  SettingController.swift
//  Youtube
//
//  Created by Ashwini shalke on 20/03/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit

class SettingController:NSObject,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    let blackView = UIView()
    let cellID = "cellID"
    let collectionView: UICollectionView = {
        let cv = UICollectionView()
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    override init() {
        super.init()
        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: cellID)
    }
    func handleSetting(){
        self.blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        if let window = UIApplication.shared.keyWindow { 
            window.addSubview(blackView)
            blackView.frame = window.frame
            blackView.alpha = 0
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
            }, completion: nil)
        }
    }
    
    @objc func handleDismiss(){
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        return cell
    }
    
}
