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

    var index: Int = 0
    var streamURI: String = ""
    var isPlaying: Bool = false
    
    //MARK: ViewController lifecycle.
    override func viewDidLoad() {
        super.viewDidLoad()
        initialiseVideoURL()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        player?.play()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        player?.pause()
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
