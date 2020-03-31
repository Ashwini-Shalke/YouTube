//
//  ViewController.swift
//  Youtube
//
//  Created by Ashwini shalke on 06/02/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "CellID"
    let trendingCellId = "TrendingCellID"
    let subscriptionCellId = "SubscriptionCellID"
    
    var videosArray: [Video]?
    let titleNames = ["Home", "Trending","Subscription","Account"]
    
    lazy var menuBar: MenuBar = {
        var mb = MenuBar()
        mb.homeController = self
        return mb
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        let barLabel = UILabel()
        barLabel.text = "Home"
        barLabel.font = UIFont.systemFont(ofSize: 20)
        barLabel.textColor = UIColor.white
        barLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height)
        navigationItem.titleView = barLabel
        
        let redView = UIView()
        redView.backgroundColor = UIColor.rgbColor(red: 230, green: 32, blue: 31)
        view.addSubview(redView)
        view.addConstraintswithFormat(format: "H:|[v0]|", views: redView)
        view.addConstraintswithFormat(format: "V:[v0(50)]", views: redView)
        view.addSubview(menuBar)
        navigationController?.hidesBarsOnSwipe = true
        view.addConstraintswithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintswithFormat(format: "V:[v0(50)]", views: menuBar)
        setupCollectionView()
        menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        setupNavBar()
    }
    
    func setupCollectionView(){
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(TrendingCell.self, forCellWithReuseIdentifier: trendingCellId)
        collectionView.register(SubscriptionCell.self, forCellWithReuseIdentifier: subscriptionCellId)
        
        collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.isPagingEnabled = true
    }
    
    
    
    func setupNavTitle(index: Int){
        if let titleLables = navigationItem.titleView as? UILabel {
            titleLables.text = titleNames[index]
        }
    }
    
    
    func setupNavBar(){
        let searchImage = UIImage(named: "searchIcon")?.withRenderingMode(.alwaysOriginal)
        let searchButton = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        let moreButton = UIBarButtonItem(image: UIImage(named: "menuIcon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMenu))
        navigationItem.rightBarButtonItems = [moreButton,searchButton]
    }
    
    
    @objc func handleSearch(){
        
    }
    
    func scrollToMenuIndex(menuIndex: Int){
        let indexPath = NSIndexPath(item: menuIndex, section: 0)
        collectionView.scrollToItem(at: indexPath as IndexPath, at: [], animated: true)
        setupNavTitle(index: menuIndex)
    }
    
    
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = Int(targetContentOffset.pointee.x / view.frame.width)
        let indexPath = NSIndexPath(item: index, section: 0)
        menuBar.collectionView.selectItem(at: indexPath as IndexPath, animated: true, scrollPosition: .centeredHorizontally)
       setupNavTitle(index: index)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 4
        
    }
    
    lazy var settingLauncher:SettingLauncher = {
        let launcher = SettingLauncher()
        launcher.homeController = self
        return launcher
    }()
    
    @objc func handleMenu(){
        settingLauncher.handleSetting()
    }
    
    func showControllerForSetting(setting : Setting){
        let dummyController = UIViewController()
        dummyController.view.backgroundColor = UIColor.white
        dummyController.navigationItem.title = setting.labelName.rawValue
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.pushViewController(dummyController, animated: true)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier:String
        if (indexPath.item == 1){
            identifier = trendingCellId
        } else if (indexPath.item == 2) {
            identifier = subscriptionCellId
        } else { identifier = cellId }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 50)
    }
}





