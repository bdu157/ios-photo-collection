//
//  PhotoController.swift
//  PhotoCollection
//
//  Created by Dongwoo Pae on 5/16/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import Foundation
class PhotoController {
    var photos: [Photo] = []
    
    func createPhoto(photoImage: Data, title: String) {
        let input = Photo.init(imageData: photoImage, title: title)
        photos.append(input)
    }
    
    func updatePhoto(for photo: Photo, updateImageDataTo imageData: Data, updateTitleTo title:String) {
        guard let index = photos.firstIndex(of: photo) else {return}
            photos[index].imageData = imageData
            photos[index].title = title
    }
}
