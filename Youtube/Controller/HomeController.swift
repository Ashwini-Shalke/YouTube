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
    
    var videosArray: [Video]?

    func getVideoData(){
        let urlString = "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else {return}
            do {
                self.videosArray = try JSONDecoder().decode([Video].self,  from: data)
                DispatchQueue.main.async { self.collectionView.reloadData() }
            } catch let jsonErr {
                print("Unable to fetch Data",jsonErr)
            }
        }.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getVideoData()
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
        
        setupNavBar()
    }
    
    func setupNavBar(){
        let searchImage = UIImage(named: "searchIcon")?.withRenderingMode(.alwaysOriginal)
        let searchButton = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
     
    
        let moreButton = UIBarButtonItem(image: UIImage(named: "menuIcon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMenu))
        navigationItem.rightBarButtonItems = [moreButton,searchButton]
    }
    
    
    @objc func handleSearch(){
        
    }
    
    @objc func handleMenu(){
        
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videosArray?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
        cell.video = videosArray?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 16 - 16) * 9/16
        return CGSize(width: view.frame.width, height: height + 16 + 88)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}





