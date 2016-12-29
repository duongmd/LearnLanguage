//
//  addLanguage.swift
//  Learning-Language
//
//  Created by PIRATE on 11/11/16.
//  Copyright © 2016 Duong. All rights reserved.
//

import UIKit
import MobileCoreServices

class addLanguage: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    var defaults = UserDefaults.standard
    
    var imagePicker: UIImagePickerController?

    let database = DataBase.sharedInstance

    @IBOutlet weak var nameLanguage: UITextField!
    
    @IBOutlet weak var imageLanguage: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(getImage(_:)))
        imageLanguage.isUserInteractionEnabled = true
        imageLanguage.addGestureRecognizer(tap)
    }
    
    func getImage(_ gesture: UITapGestureRecognizer){
        
        imagePicker = UIImagePickerController()
        
        //Kiem tra thiet bi co camera ko thi hien thi thong bao
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            let alert = UIAlertController(title: "Get Image", message: "Where do you want to get image?", preferredStyle: .actionSheet)
            
            let cameraButton = UIAlertAction(title: "Camera", style: .destructive, handler: { (_) in
                self.presentImagePickerController(sourceType: .camera)
            })
            
            let photoLibraryButton = UIAlertAction(title: "Photo Library", style: .default, handler: { (_) in
                self.presentImagePickerController(sourceType: .photoLibrary)
            })
            
            let cancelButton = UIAlertAction(title: "Cancel", style: .default, handler: { (_) in
                
            })
            
            alert.addAction(cameraButton)
            alert.addAction(photoLibraryButton)
            alert.addAction(cancelButton)
            
            self.present(alert, animated: true, completion: nil)
            
        } else {
            self.presentImagePickerController(sourceType: .photoLibrary)
        }
        
    }
    func presentImagePickerController(sourceType: UIImagePickerControllerSourceType) {
        self.imagePicker?.sourceType = sourceType
        self.imagePicker?.allowsEditing = false
        self.imagePicker?.delegate = self
        self.imagePicker?.modalPresentationStyle = .currentContext
        self.present(imagePicker!, animated: true, completion: nil)
    }
    
    @IBAction func Save(_ sender: AnyObject) {

        let doccumentsDirectoryURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)

        writeImage(path: doccumentsDirectoryURL, imageName: nameLanguage.text!, image: imageLanguage.image!)
        
        let urlImage = doccumentsDirectoryURL.absoluteString + nameLanguage.text!
        
        let idUser = defaults.object(forKey: "idUser")
        database.insertDataBase("Language",  dict: ["LanguageName":nameLanguage.text! ,"UrlImg": urlImage, "IdUser": idUser!])

        
        _ = self.navigationController?.popViewController(animated: true)

    }
    func writeImage(path : URL, imageName : String, image : UIImage) {
        
        let newPath = path.appendingPathComponent(imageName)
        
        do {
            try UIImagePNGRepresentation(image)?.write(to: newPath)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
    }
  
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        //Lay hinh anh tu PhotoLibrary
        if let mediaType = info[UIImagePickerControllerMediaType] as? String, mediaType == kUTTypeImage as String
        {
            if (info[UIImagePickerControllerReferenceURL] as? URL) != nil {
                if let img = info[UIImagePickerControllerOriginalImage] as? UIImage {
                    self.imageLanguage.image = img
                }
            } else {
                //Lay hinh anh tu camera
                if let img = info[UIImagePickerControllerOriginalImage] as? UIImage{
                    self.imageLanguage.image = img
                }
            }
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}




