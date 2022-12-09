//
//  ImageCell.swift
//  NASAGalleryApp
//
//  Created by Saravana kumar on 09/12/22.
//

import UIKit

class ImageCell : UICollectionViewCell {
    
    var galleryImage = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(galleryImage)
        galleryImage.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
