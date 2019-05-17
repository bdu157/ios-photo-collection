//
//  PhotoDetailViewController.swift
//  PhotoCollection
//
//  Created by Dongwoo Pae on 5/16/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var textField: UITextField!
    
    
    var photoController: PhotoController?
    var photo: Photo?
    var themeHelper: ThemeHelper? {
        didSet {
            loadViewIfNeeded()
            updateViews()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Do any additional setup after loading the view.
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
    
    @IBAction func savePhoto(_ sender: Any) {
        guard let photoImage = imageView.image,
            let title = textField.text,
            let photoData = photoImage.jpegData(compressionQuality: 1.0) else {return}
        if photo == nil {
            photoController?.createPhoto(photoImage: photoData, title: title)
        } else {
            guard let photo  = photo else {return}
            photoController?.updatePhoto(for: photo, updateImageDataTo: photoData, updateTitleTo: title)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    func setTheme() {
        guard let themePreference = themeHelper?.themePreference else {return}
        if themePreference == "Dark" {
            self.view.backgroundColor = .gray
        } else if themePreference == "Orange" {
            self.view.backgroundColor = .orange
        }
    }
    
    func updateViews() {
        setTheme()
        guard let photo = photo else {return}
        let image = UIImage(data: photo.imageData)
            imageView.image = image
        
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
    
    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[Privacy - Photo, MTLLibrary Usage Description] as? UIImage else { return }
        imageView.image = image
        
    }
    
}
