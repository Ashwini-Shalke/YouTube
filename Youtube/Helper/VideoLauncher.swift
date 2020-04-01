//
//  VideoLauncher.swift
//  Youtube
//
//  Created by Ashwini shalke on 01/04/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.lightGray
        
        let urlString = "https://firebasestorage.googleapis.com/v0/b/gameofchats-762ca.appspot.com/o/message_movies%2F12323439-9729-4941-BA07-2BAE970967C7.mov?alt=media&token=3e37a093-3bc8-410f-84d3-38332af9c726"
        if let url = NSURL(string: urlString) {
            let videoPlayer = AVPlayer(url: url as URL)
            let playerLayer =  AVPlayerLayer(player: videoPlayer)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            videoPlayer.play()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class VideoLauncher: NSObject {
    func showVideoPlayer(){
        if let keywindow = UIApplication.shared.keyWindow {
            let view = UIView(frame: keywindow.frame)
            view.backgroundColor = UIColor.white
            view.frame = CGRect(x: keywindow.frame.width - 10, y: keywindow.frame.height - 10, width: 10, height: 10)
            
            
            let height = keywindow.frame.width * 9/16
            let videoPlayerFrame = CGRect(x: 0, y: 0, width: keywindow.frame.width, height: height)
            let videoPlayer = VideoPlayerView(frame: videoPlayerFrame)
            
            view.addSubview(videoPlayer)
            keywindow.addSubview(view)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                view.frame = keywindow.frame
            }) { (completedAnimation) in
                UIApplication.shared.setStatusBarHidden(true, with: .fade)
            }
        }
    }
}
