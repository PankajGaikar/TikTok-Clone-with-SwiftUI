//
//  Constants.swift
//  VideoBrowser
//
//  Created by Pankaj Gaikar on 26/08/20.
//  Copyright © 2020 Pankaj Gaikar. All rights reserved.
//

import Foundation

struct Constants {

    struct LocalJSONFile {
        static let Name = "assignment"
        static let Extension = "json"
    }
    
    struct CellIdentifiers {
        static let CategoryTableViewCellIdentifier = "CategoryTableViewCell"
        static let VideoCollectionViewCellIdentifier = "VideoCollectionViewCell"
    }
        
    struct StoryboardIDs {
        static let VideosPageViewControllerIdentifier = "VideosPageViewController"
        static let StreamViewControllerIdentifier = "StreamViewController"
    }
    
    struct Placeholders {
        static let VideoThumbnailPlaceholder = "popcorn.png"
    }
    
    struct Strings {
        static let StoryboardMain = "Main"
    }
}
