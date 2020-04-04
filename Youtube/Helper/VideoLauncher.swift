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
    var videoPlayer:AVPlayer?
    var isplaying = false
    
    let activityindicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = UIColor.white
        indicator.startAnimating()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    let playPauseButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "pause")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor.white
        button.isHidden = true
        button.addTarget(self, action: #selector(handlePlayPause), for: .touchUpInside)
        
        return button
    }()
    
    let controlContainerView: UIView = {
        
        let cv = UIView()
        cv.backgroundColor = UIColor(white: 0, alpha: 0.5)
        return cv
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupVideoPlayer()
        controlContainerView.frame = frame
        addSubview(controlContainerView)
        
        controlContainerView.addSubview(activityindicator)
        activityindicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityindicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        controlContainerView.addSubview(playPauseButton)
        playPauseButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        playPauseButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        playPauseButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        playPauseButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
     
        backgroundColor = UIColor.black
    }
    
    @objc func handlePlayPause() {
        if (isplaying){
            videoPlayer?.pause()
            playPauseButton.setImage(UIImage(named: "play"), for: .normal)
        }else {
            videoPlayer?.play()
            playPauseButton.setImage(UIImage(named: "pause"), for: .normal)
        }
        isplaying = !isplaying
    }
    
    
   private func setupVideoPlayer() {
        let urlString = "https://firebasestorage.googleapis.com/v0/b/gameofchats-762ca.appspot.com/o/message_movies%2F12323439-9729-4941-BA07-2BAE970967C7.mov?alt=media&token=3e37a093-3bc8-410f-84d3-38332af9c726"
        if let url = NSURL(string: urlString) {
            videoPlayer = AVPlayer(url: url as URL)
            let playerLayer =  AVPlayerLayer(player: videoPlayer)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            videoPlayer?.play()
            videoPlayer?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            activityindicator.stopAnimating()
            controlContainerView.backgroundColor = .clear
            playPauseButton.isHidden = false
            isplaying = true
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
