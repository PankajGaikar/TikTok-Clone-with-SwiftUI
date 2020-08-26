//
//  VideosPageViewController.swift
//  VideoBrowser
//
//  Created by Pankaj Gaikar on 26/08/20.
//  Copyright © 2020 Pankaj Gaikar. All rights reserved.
//

import UIKit

typealias VideoIndex = (streamURI: String, playbackIndex: Int)

class VideosPageViewController: UIPageViewController {

    var nodes: [Node] = [Node]()
    var selectedIndex: Int = 0
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPagination()
        setupInitialStream()
    }
    
    //MARK: Setup UIPageViewController
    fileprivate func setupPagination() {
        self.dataSource = self
        self.delegate = self
        let dismissStreamGesture = UISwipeGestureRecognizer(target: self, action: #selector(closeView))
        dismissStreamGesture.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(dismissStreamGesture)
    }
    
    //MARK: Setup initial stream
    fileprivate func setupInitialStream() {
        let viewController = StreamViewController.initialize(urlString: nodes[selectedIndex].video.encodeURI, andIndex: selectedIndex, isPlaying: true)
        setViewControllers([viewController], direction: .forward, animated: true, completion: nil)
    }

    //MARK: Swipe to close window
    @objc private func closeView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: Instantiate current view controller
    static func initialize(with nodes:[Node], index: Int) -> VideosPageViewController {
        let storyboard = UIStoryboard(name: Constants.Strings.StoryboardMain, bundle: nil)
        let videosPageViewController = storyboard.instantiateViewController(identifier: Constants.StoryboardIDs.VideosPageViewControllerIdentifier) as! VideosPageViewController
        videosPageViewController.nodes = nodes
        videosPageViewController.selectedIndex = index
        return videosPageViewController
    }
    
    //MARK: Index and stream data handler.
    private func updateVideoIndex(fromIndex index: Int) {
        selectedIndex = index
    }
    
    private func getPreviousVideoIndex() -> VideoIndex? {
        return getVideoIndex(atIndex: selectedIndex - 1)
    }
    
    private func getNextVideoIndex() -> VideoIndex? {
        return getVideoIndex(atIndex: selectedIndex + 1)
    }

    private func getVideoIndex(atIndex index: Int) -> VideoIndex? {
        guard index >= 0 && index < nodes.count else {
            return nil
        }
        return (streamURI: nodes[index].video.encodeURI, playbackIndex: index)
    }
    
}

//MARK: PageViewController Delegates and Datasources.
extension VideosPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let videoIndex = getPreviousVideoIndex() else {
            return nil
        }

        return StreamViewController.initialize(urlString: videoIndex.streamURI, andIndex: videoIndex.playbackIndex, isPlaying: true)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let videoIndex = getNextVideoIndex() else {
            return nil
        }

        return StreamViewController.initialize(urlString: videoIndex.streamURI, andIndex: videoIndex.playbackIndex, isPlaying: true)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard completed else { return }
        
        if let viewController = pageViewController.viewControllers?.first as? StreamViewController,
            let previousViewController = previousViewControllers.first as? StreamViewController {
            previousViewController.pausePlayingVideo()
            viewController.startPlayingVideo()
            self.updateVideoIndex(fromIndex: viewController.index)
        }
    }
}

