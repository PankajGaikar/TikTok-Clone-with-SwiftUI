//
//  CategoryTableViewCell.swift
//  VideoBrowser
//
//  Created by Pankaj Gaikar on 26/08/20.
//  Copyright © 2020 Pankaj Gaikar. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    static func getNib() -> UINib {
        return UINib(nibName: Constants.CellIdentifiers.CategoryTableViewCellIdentifier, bundle: .main)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
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
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let videoCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentifiers.VideoCollectionViewCellIdentifier, for: indexPath) as! VideoCollectionViewCell
        return videoCollectionCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        return CGSize(width: collectionViewWidth/3, height: self.frame.height - 20)
    }
}
