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
}

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photoController.photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PhotoCollectionViewCell
            let photo = self.photoController.photos[indexPath.item]
            cell.photo?.imageData = photo.imageData
            cell.photo?.title = photo.title
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
        if themePreference == "Dark" {
            self.collectionView.backgroundColor = .gray
        } else if themePreference == "Orange" {
            self.collectionView.backgroundColor = .orange
        }
    }

}
