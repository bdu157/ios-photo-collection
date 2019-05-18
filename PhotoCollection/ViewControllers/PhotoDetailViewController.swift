//
//  PhotoDetailViewController.swift
//  PhotoCollection
//
//  Created by Dongwoo Pae on 5/16/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit
import Photos

class PhotoDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var textField: UITextField!
    
    
    var photoController: PhotoController?
    var photo: Photo?
    var themeHelper: ThemeHelper?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateViews()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func addPhoto(_ sender: Any) {
        let preservedStatus = PHPhotoLibrary.authorizationStatus()
        switch preservedStatus {
        case .authorized:
            self.presentImagePickerController()
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({ (newStatus) in
                if newStatus == .authorized {
                    self.presentImagePickerController()
                } else {
                    return
                }
            })
        default:
            return
        }
        
        
    }
    
    @IBAction func saveButton(_ sender: Any) {
        guard let photoImage = imageView.image,
            let title = textField.text,
            let photoData = photoImage.jpegData(compressionQuality: 1.0) else {return}
        if photo == nil {
            photoController?.createPhoto(photoImage: photoData, title: title)
            navigationController?.popToRootViewController(animated: true)
        } else {
            guard let photo  = photo else {return}
            photoController?.updatePhoto(for: photo, updateImageDataTo: photoData, updateTitleTo: title)
        }
            navigationController?.popToRootViewController(animated: true)
    }

    
    func setTheme() {
        guard let themePreference = themeHelper?.themePreference else {return}
        if themePreference == "Cyan" {
            self.view.backgroundColor = .cyan
        } else if themePreference == "Orange" {
            self.view.backgroundColor = .orange
        }
    }
    
    func updateViews() {
        setTheme()
        if let photo = photo {
            navigationItem.title = "Edit Photo"
            self.imageView.image = UIImage(data: photo.imageData)
            self.textField.text = photo.title
        } else {
            navigationItem.title = "Create Photo"
        }
    }
    
    func presentImagePickerController() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion: nil)
        } else {
            return
        }
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[.originalImage] as? UIImage else { return }
        imageView.image = image
        
    }
    
}
