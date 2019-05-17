//
//  PhotoCollectionViewCell.swift
//  PhotoCollection
//
//  Created by Dongwoo Pae on 5/16/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    var photo: Photo? {
        didSet {
            updateViews()
        }
    }
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    
    func updateViews() {
        guard let photo = photo else {return}
        imageView.image = UIImage(data: photo.imageData)
        label.text = photo.title
    }
}
