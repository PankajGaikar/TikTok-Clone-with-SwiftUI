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
    
    struct Dimensions {
        static let TableViewEstimatedRowHeight = 100.0
        static let HeaderViewHeight = 30.0
    }
}
