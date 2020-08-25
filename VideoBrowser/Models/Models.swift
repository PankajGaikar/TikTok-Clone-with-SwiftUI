//
//  Models.swift
//  VideoBrowser
//
//  Created by Pankaj Gaikar on 26/08/20.
//  Copyright © 2020 Pankaj Gaikar. All rights reserved.
//

import Foundation

struct Category: Codable {
    let title: String
    let nodes: [Node]
}

struct Node: Codable {
    let video: Video
}

struct Video: Codable {
    let encodeURI: String
    
    enum CodingKeys: String, CodingKey {
        case encodeURI = "encodeUrl"
    }
}
