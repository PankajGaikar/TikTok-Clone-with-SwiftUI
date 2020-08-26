//
//  StreamViewController.swift
//  VideoBrowser
//
//  Created by Pankaj Gaikar on 26/08/20.
//  Copyright © 2020 Pankaj Gaikar. All rights reserved.
//

import UIKit
import AVKit

class StreamViewController: AVPlayerViewController {
    
    //MARK: Properties
    var index: Int = 0
    var streamURI: String = ""
    var isPlaying: Bool = false
    
    //MARK: UI
    var loader = UIActivityIndicatorView(style: .large)
    
    //MARK: ViewController lifecycle.
    override func viewDidLoad() {
        super.viewDidLoad()
        initialiseVideoURL()
        setupUI()
        observePlaybackState()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        player?.play()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        player?.pause()
    }
    
    fileprivate func setupUI() {
        self.showsPlaybackControls = false
        self.contentOverlayView?.addSubview(loader)
        self.contentOverlayView?.center = self.view.center
        if let center = self.contentOverlayView?.center {
            loader.center = center
        }
        loader.color = .white
        loader.startAnimating()
        loader.hidesWhenStopped = true
    }
    
    /*
     * This method will observe playback button.
     * Will stop ActivityIndicator once video starts playing.
     */
    func observePlaybackState() {
        self.player?.addPeriodicTimeObserver(forInterval: CMTimeMake(value: 1, timescale: 600), queue: DispatchQueue.main, using: { [weak self] time in
            if self?.player?.currentItem?.status == AVPlayerItem.Status.readyToPlay {
                if self?.player?.currentItem?.isPlaybackLikelyToKeepUp ?? false {
                    self?.loader.stopAnimating()
                }
            }
        })
    }
    
    //MARK: Instantiate ViewController.
    static func initialize(urlString: String, andIndex index: Int, isPlaying: Bool = false) -> StreamViewController {
        let storyboard = UIStoryboard(name: Constants.Strings.StoryboardMain, bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: Constants.StoryboardIDs.StreamViewControllerIdentifier) as! StreamViewController
        viewController.streamURI = urlString
        viewController.index = index
        viewController.isPlaying = isPlaying
        return viewController
    }
    
    //MARK: Playback Handlers
    func initialiseVideoURL() {
        guard let url = URL(string: streamURI) else { return }
        player = AVPlayer(url: url)
        isPlaying ? startPlayingVideo() : nil
    }
    
    func startPlayingVideo() {
        player?.play()
    }
    
    func pausePlayingVideo() {
        player?.pause()
    }

}
