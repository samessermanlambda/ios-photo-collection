//
//  PhotoDetailViewController.swift
//  Photo-Collection (AP)
//
//  Created by Samuel Esserman on 2/27/20.
//  Copyright © 2020 Samuel Esserman. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    
    var photoController: PhotoController?
    var photo: Photo?
    var themeHelper: ThemeHelper?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
//MARK: - ViewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        setTheme()
        updateViews()
    }
    
//MARK: - Action: Add Photo
    @IBAction func addPhoto(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }

//MARK: - SetTheme
    func setTheme() {
        if let themeHelper = themeHelper {
            if themeHelper.themePreference == "Dark" {
                view.backgroundColor = .darkGray
            } else {
                view.backgroundColor = .white
            }
        }
    }
//MARK: - UpdateViews
    func updateViews() {
        if let photo = photo {
            photoImageView.image = UIImage(data: photo.imageData)
            titleTextField.text = photo.title
        }
    }
//MARK: - Save Button Action
    @IBAction func saveButtonTapped(_ sender: Any) {
        if let photo = photo {
            if let photoController = photoController {
                if let text = titleTextField.text, !text.isEmpty, let photoData = photoImageView.image?.pngData() {
                    photoController.update(photo: photo, title: text, data: photoData)
                }
            }
        } else {
            if let photoController = photoController {
                if let text = titleTextField.text, !text.isEmpty {
                    let photoData = photoImageView.image?.jpegData(compressionQuality: 1)
                    photoController.createPhoto(title: text, imageData: photoData!)
                }
            }
        }
        navigationController?.popViewController(animated: true)
    }
//MARK: - Image Picker Controller
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           guard let image = info[.editedImage] as? UIImage else { return }
           
           photoImageView.image = image
           dismiss(animated: true)
           
       }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
