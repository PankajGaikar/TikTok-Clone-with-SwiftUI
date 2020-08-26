//
//  CategoryTableViewCell.swift
//  VideoBrowser
//
//  Created by Pankaj Gaikar on 26/08/20.
//  Copyright © 2020 Pankaj Gaikar. All rights reserved.
//

import UIKit

protocol VideoCellSelectionDelegate: AnyObject {
    func playCategoryVideos(with nodes: [Node], selectedIndex: Int)
}

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    //Array of categorised videos.
    var nodes: [Node] = []
    weak var delegate: VideoCellSelectionDelegate?

    static func getNib() -> UINib {
        return UINib(nibName: Constants.CellIdentifiers.CategoryTableViewCellIdentifier, bundle: .main)
    }
        
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }

    fileprivate func setupCollectionView() {
        collectionView.register(VideoCollectionViewCell.getNib(), forCellWithReuseIdentifier: Constants.CellIdentifiers.VideoCollectionViewCellIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

extension CategoryTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nodes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let videoCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentifiers.VideoCollectionViewCellIdentifier, for: indexPath) as! VideoCollectionViewCell
        
        //Check if URI exists. If not, default URI is assigned from xib file itself.
        if nodes.count > indexPath.row, let thumbnailURI = URL(string: nodes[indexPath.row].video.encodeURI) {
            videoCollectionCell.imageView.generateVideoThumbnail(from: thumbnailURI)
        }
        
        return videoCollectionCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.playCategoryVideos(with: nodes, selectedIndex: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        
        //Set 2.5 collection items visible at beginning. Just random number 🤨
        return CGSize(width: collectionViewWidth/2.8, height: self.frame.height - 20)
    }

}
