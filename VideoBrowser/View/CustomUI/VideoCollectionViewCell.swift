//
//  VideoCollectionViewCell.swift
//  VideoBrowser
//
//  Created by Pankaj Gaikar on 26/08/20.
//  Copyright © 2020 Pankaj Gaikar. All rights reserved.
//

import UIKit

class VideoCollectionViewCell: UICollectionViewCell {

    static func getNib() -> UINib {
        return UINib(nibName: Constants.CellIdentifiers.VideoCollectionViewCellIdentifier, bundle: .main)
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageView.layer.cornerRadius = 10
    }

}
