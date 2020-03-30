//
//  FeedCell.swift
//  Youtube
//
//  Created by Ashwini shalke on 29/03/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit

class FeedCell : BaseCell, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    var videosArray: [Video]?
    let cellId = "CellId"
    lazy var collectionView: UICollectionView = {
          let layout = UICollectionViewFlowLayout()
          let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
          cv.backgroundColor = UIColor.white
          cv.delegate = self
          cv.dataSource = self
          return cv
      }()
      
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
    
    override func setup() {
        addSubview(collectionView)
        addConstraintswithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintswithFormat(format: "V:|[v0]|", views: collectionView)
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: cellId)
        getVideoData()
    }
    
  
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videosArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! VideoCell
        cell.video = videosArray?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (frame.width - 16 - 16) * 9/16
        return CGSize(width: frame.width, height: height + 16 + 88)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}