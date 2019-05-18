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
        saveToPersistentStore()
    }
    
    func updatePhoto(for photo: Photo, updateImageDataTo imageData: Data, updateTitleTo title:String) {
        guard let index = photos.firstIndex(of: photo) else {return}
            photos[index].imageData = imageData
            photos[index].title = title
            saveToPersistentStore()
    }
    
    init() {reloadFromPersistentStore()}
    
    
    //create a file
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documentDiretory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        return documentDiretory.appendingPathComponent("PhotoList.plist")
        
    }
    
    //save it to location(file)
    func saveToPersistentStore() {
        guard let url = readingListURL else {return}
        do {
            let encoder = PropertyListEncoder()
            let photosDatas = try encoder.encode(photos)
            try photosDatas.write(to: url)
        } catch {
            NSLog("error saving books data: \(error)")
        }
    }
    
    //reload it from location (file)
    func reloadFromPersistentStore() {
        let fileManager = FileManager.default
        guard let url = readingListURL,
            fileManager.fileExists(atPath: url.path) else {return}
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodePhoto = try decoder.decode([Photo].self, from: data)
            self.photos = decodePhoto
        } catch {
            NSLog("error loading books data:\(error)")
        }
    }
    
}
