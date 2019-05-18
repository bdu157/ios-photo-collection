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
    
    var themeHelper: ThemeHelper?
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    
    func updateViews() {
        guard let photoData = photo?.imageData,
            let title = photo?.title else {return}
        self.imageView.image = UIImage(data: photoData)
        self.label.text = title
    }
    
}
