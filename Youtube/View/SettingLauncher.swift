//
//  SettingController.swift
//  Youtube
//
//  Created by Ashwini shalke on 20/03/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit

class Setting: NSObject {
    let labelName: SettingName
    let imageName: String
    init(labelName: SettingName, imageName: String){
        self.labelName = labelName
        self.imageName = imageName
    }
}


class SettingLauncher:NSObject,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    let blackView = UIView()
    let cellID = "cellID"
    let cellHeight: CGFloat = 50
    var homeController:HomeController?
    
    var settings: [Setting] = {
        let setting = Setting(labelName: .Setting , imageName: "settings")
        let termSetting = Setting(labelName: .Term , imageName: "privacy")
        let feedbackSetting = Setting(labelName: .Feedback, imageName: "feedback")
        let helpSetting = Setting(labelName: .Help, imageName: "help")
        let switchSetting = Setting(labelName: .Switch, imageName: "switch_account")
        let cancelSetting = Setting(labelName: .Cancel, imageName: "cancel")
        return [setting,termSetting,feedbackSetting, helpSetting, switchSetting,cancelSetting]
    }()
    
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    
    override init() {
        super.init()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.isScrollEnabled = false
    }
    
    func handleSetting(){
        self.blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        if let window = UIApplication.shared.keyWindow { 
            window.addSubview(blackView)
            window.addSubview(collectionView)
            
            let verticalSafeAreaInset: CGFloat
            if #available(iOS 11.0, *) {
                verticalSafeAreaInset = window.safeAreaInsets.bottom + window.safeAreaInsets.top
            } else {
                verticalSafeAreaInset = 0.0
            }
            let safeAreaHeight = window.frame.height - verticalSafeAreaInset
            
            blackView.frame = window.frame
            blackView.alpha = 0
            
            let menuHeight = CGFloat(settings.count) * cellHeight
            let y = window.frame.height - menuHeight
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: safeAreaHeight)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }, completion: nil)
        }
    }
    
    @objc func handleDismiss(setting: Setting?){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height) }
        }, completion: nil
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = CGSize(width: collectionView.frame.width, height: cellHeight)
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SettingCell
        cell.setting = settings[indexPath.item]
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        }) { ( result ) in
            let setting = self.settings[indexPath.item]
            self.homeController?.showControllerForSetting(setting: setting)
        }
    }
}

