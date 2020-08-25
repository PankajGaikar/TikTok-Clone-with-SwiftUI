//
//  Extensions.swift
//  VideoBrowser
//
//  Created by Pankaj Gaikar on 26/08/20.
//  Copyright © 2020 Pankaj Gaikar. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

/*
 * Used to cache video thumbnails.
 */
private let cache = NSCache<NSString, UIImage>()

extension UIImageView {
        
    /*
     * This extension created a video thumbnail from video URI.
     */
    func generateVideoThumbnail(from url: URL) {
        
        if let image = cache.object(forKey: url.absoluteString as NSString) {
            self.image = image
        } else {
            
            self.image = UIImage(named: Constants.Placeholders.VideoThumbnailPlaceholder)
            
            let asset = AVAsset(url: url)
            let assetImgGenerate = AVAssetImageGenerator(asset: asset)
            
            assetImgGenerate.appliesPreferredTrackTransform = true
            assetImgGenerate.maximumSize = CGSize(width: self.frame.width, height: self.frame.height)
            
            let time = CMTimeMakeWithSeconds(0.0, preferredTimescale: 600)
            DispatchQueue.global(qos: .background).async {
                
                do {
                    //Attempt to download video thumbnail.
                    let img = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
                    let thumbnail = UIImage(cgImage: img)
                    cache.setObject(thumbnail, forKey: url.absoluteString as NSString)
                    DispatchQueue.main.async {
                        self.image = thumbnail
                    }
                }
                catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
}
