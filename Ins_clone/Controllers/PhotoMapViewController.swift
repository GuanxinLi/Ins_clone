//
//  PhotoMapViewController.swift
//  Ins_clone
//
//  Created by Guanxin Li on 2/26/18.
//  Copyright © 2018 Guanxin. All rights reserved.
//

import UIKit

class PhotoMapViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var selectPhotoButton: UIButton!
    @IBOutlet var uploadPhotoView: UIView!
    @IBOutlet weak var uploadedImageView: UIImageView!
    @IBOutlet weak var captureTextField: UITextField!
    @IBOutlet weak var postButton: UIButton!
    let vc = UIImagePickerController()
    let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
        //does nothing -> dismisses alert view
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        vc.delegate = self
        uploadedImageView.image = nil
        captureTextField.text = nil
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
        //let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        // Do something with the images (based on your use case)
        uploadedImageView.contentMode = .scaleAspectFit
        uploadedImageView.image = editedImage
        uploadPhotoView.backgroundColor = .clear
        selectPhotoButton.setTitle("", for: .normal)
        dismiss(animated: true, completion: nil)
    }
    
    func cancelImagePickerController (_ picker: UIImagePickerController) {
        vc.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*{(arg1, arg2) ->(Return type) in
     //Here is your code
     }*/
    
    @IBAction func postButtonPressed(_ sender: UIButton) {
        if (uploadedImageView.image == nil){
            let missingPhotoAlertController = UIAlertController(title: "Photo Required", message: "Please select a valid photo.", preferredStyle: .alert)
            missingPhotoAlertController.addAction(OKAction)
            present(missingPhotoAlertController, animated: true)
        } else if (captureTextField.text?.isEmpty)! {
            let missingCaptureAlertController = UIAlertController(title: "Capture Required", message: "Please enter valid capture.", preferredStyle: .alert)
            missingCaptureAlertController.addAction(OKAction)
            present(missingCaptureAlertController, animated: true)
        } else {
            Post.postUserImage(image: uploadedImageView.image, withCaption: captureTextField.text, withCompletion: {(success, error) in
                if success {
                    print("Sucessfully posted")
                } else {
                    print ("Error")
                }
            })
            uploadedImageView.image = nil
            captureTextField.text = ""
            selectPhotoButton.setTitle("Tap to select image", for: .normal)
            super.tabBarController?.selectedIndex = 0
        }
        
        
        
    }
    
    
    @IBAction func onPressButtonToSelectImage(_ sender: Any) {
        vc.allowsEditing = true
        //vc.sourceType = UIImagePickerControllerSourceType.camera
        self.present(vc, animated: true, completion: nil)
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
