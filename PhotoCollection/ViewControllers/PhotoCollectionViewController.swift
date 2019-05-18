//
//  PhotoCollectionViewController.swift
//  PhotoCollection
//
//  Created by Dongwoo Pae on 5/16/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class PhotoCollectionViewController: UICollectionViewController {
    
    let photoController = PhotoController()
    let themeHelper = ThemeHelper()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setTheme()
        collectionView.reloadData()
}

    override func viewDidLoad() {
        super.viewDidLoad()

    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photoController.photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCollectionViewCell
            let photo = self.photoController.photos[indexPath.row]
            cell.photo = photo
            return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToPhotoDetailVC" {
            guard let destVC = segue.destination as? PhotoDetailViewController else {return}
                destVC.themeHelper = themeHelper
                destVC.photoController = photoController
        } else if segue.identifier == "ToPhotoDetailVCfromCell" {
            guard let destVC = segue.destination as? PhotoDetailViewController,
                let indexPath = collectionView.indexPathsForSelectedItems?.first else {return}
                destVC.themeHelper = themeHelper
                destVC.photoController = photoController
                destVC.photo = photoController.photos[indexPath.item]
        } else if segue.identifier == "ToThemeSelectionVC" {
            guard let destVC = segue.destination as? ThemeSelectionViewController else {return}
                destVC.themeHelper = themeHelper
        }
    }
    
    
    func setTheme() {
        guard let themePreference = themeHelper.themePreference else {return}
        if themePreference == "Cyan" {
            self.collectionView.backgroundColor = .cyan
        } else if themePreference == "Orange" {
            self.collectionView.backgroundColor = .orange
        }
    }

}
