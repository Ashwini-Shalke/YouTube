//
//  Trending.swift
//  Youtube
//
//  Created by Ashwini shalke on 31/03/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit

class TrendingCell: FeedCell{
    
    override func fetchVideoData() {
        ApiService.sharedInstance.fetchTrending { (videos) in
            self.videosArray = videos
            self.collectionView.reloadData()
        }
    }
}
