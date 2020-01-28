//
//  ViewController.swift
//  CloudKit-Sample
//
//  Created by Francis Jemuel Bergonia on 1/15/20.
//  Copyright © 2020 Arkray PHM. All rights reserved.
//

import UIKit
import CloudKit

class ViewController: UIViewController {

    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var photoImgOutlet: UIImageView!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var retrieveBtn: UIButton!
    @IBOutlet weak var updateBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textfield.delegate = self
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectFromGallery(tapGestureRecognizer:)))
        photoImgOutlet.isUserInteractionEnabled = true
        photoImgOutlet.addGestureRecognizer(tapGestureRecognizer)
        
        CKContainer.default().fetchUserRecordID { (recordID, error) in
            if let error = error {
                print(error)
            } else if let recordID = recordID {
                print(recordID)
            }
        }
    }

    @IBAction func saveBtnTapped(_ sender: UIButton) {
        print("saveBtnTapped")
    }
    
    @IBAction func retrieveBtnTapped(_ sender: UIButton) {
        print("retrieveBtnTapped")
    }
    
    @IBAction func updateBtnTapped(_ sender: UIButton) {
        print("updateBtnTapped")
    }
    
    @IBAction func deleteBtnTapped(_ sender: UIButton) {
        print("deleteBtnTapped")
    }
}

extension ViewController: UITextFieldDelegate {
    //Set memoTextView character limit up to 20
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return textField.text!.count + (string.count - range.length) <= 20
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //MARK: PhotoLibrary Functions
    @objc private func selectFromGallery(tapGestureRecognizer: UITapGestureRecognizer) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.sourceType = .photoLibrary
            imagePickerController.delegate = self
            present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    // PhotoLibrary Functions
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.photoImgOutlet.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

