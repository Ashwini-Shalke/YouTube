//
//  SubscriptionCellCollectionViewCell.swift
//  Youtube
//
//  Created by Ashwini shalke on 31/03/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit

class SubscriptionCell: FeedCell {
   
    override func fetchVideoData() {
        ApiService.sharedInstance.fetchSubscription { (videos) in
            self.videosArray = videos
            self.collectionView.reloadData()
        }
    }
}
