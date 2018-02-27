//
//  PhotoMapViewController.swift
//  Ins_clone
//
//  Created by Guanxin Li on 2/26/18.
//  Copyright © 2018 Guanxin. All rights reserved.
//

import UIKit

class PhotoMapViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet var uploadPhotoView: UIView!
    @IBOutlet weak var uploadedImageView: UIImageView!
    @IBOutlet weak var captureTextField: UITextField!
    @IBOutlet weak var postButton: UIButton!
    let vc = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.camera
        uploadedImageView.image = nil
        captureTextField.text = nil
        self.present(vc, animated: true, completion: nil)
        // Check if the camera is available
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available.")
            vc.sourceType = .camera
        } else {
            print("Camera not available so we will use photo library instead")
            vc.sourceType = .photoLibrary
        }

    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        // Do something with the images (based on your use case)
        uploadedImageView.contentMode = .scaleAspectFit
        uploadedImageView.image = editedImage
        uploadPhotoView.backgroundColor = .clear
        dismiss(animated: true, completion: nil)
    }
    
    func cancelImagePickerController (_ picker: UIImagePickerController) {
        vc.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func postButtonPressed(_ sender: UIButton) {
        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
