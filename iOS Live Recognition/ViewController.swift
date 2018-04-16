//
//  ViewController.swift
//  iOS Live Recognition
//
//  Created by Victor Shinya on 13/04/18.
//  Copyright © 2018 Victor Shinya. All rights reserved.
//

import UIKit
import VisualRecognitionV3
import SVProgressHUD

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Global variables
    
    var visualRecognition: VisualRecognition!
    let imagePicker = UIImagePickerController()
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var photoLibraryButton: UIBarButtonItem!

    // MARK: - Lifecycle events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let defaults = UserDefaults.standard
        if let apiKey = defaults.string(forKey: Constants.key) {
            visualRecognition = VisualRecognition(apiKey: apiKey, version: "2018-04-13")
        } else {
            print("Error with API KEY")
        }
    }

    // MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        cameraButton.isEnabled = false
        photoLibraryButton.isEnabled = false
        SVProgressHUD.show()
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            imageView.image = image
            
            imagePicker.dismiss(animated: true, completion: nil)
            
            visualRecognition.classify(image: image) { classifiedImages in
                
                let classes = classifiedImages.images.first!.classifiers.first!.classes
                var results = ""
                
                for i in 0..<classes.count {
                    results.append(classes[i].className + " - \(classes[i].score! * 100)%\n")
                }
                
                print(results)
                
                DispatchQueue.main.async {
                    self.cameraButton.isEnabled = true
                    self.photoLibraryButton.isEnabled = true
                    SVProgressHUD.dismiss()
                    self.displayAlert(message: results)
                }
            }
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func photoLibraryTapped(_ sender: UIBarButtonItem) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - Custom functions
    
    func displayAlert(message: String) {
        let alert = UIAlertController(title: "Resultado", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { _ in
            alert.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
}

