//
//  PhotosCollectionViewCell.swift
//  Photo-Collection (AP)
//
//  Created by Samuel Esserman on 2/27/20.
//  Copyright © 2020 Samuel Esserman. All rights reserved.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var photo: Photo? {
        didSet {
            updateViews()
        }
    }
//MARK: - UpdateViews 
    func updateViews() {
        if let photo = photo {
            photoImageView.image = UIImage(data: photo.imageData)
            titleLabel.text = photo.title
        }
    }
}
