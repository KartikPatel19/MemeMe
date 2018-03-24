//
//  ViewController.swift
//  MemeMe
//
//  Created by kartik patel on 22/03/18.
//  Copyright © 2018 kartik patel. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UITextFieldDelegate{
    
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    
    
    struct Meme {
        let topText: String
        let bottomText: String
        let originalImage: UIImage
        let memedImage: UIImage
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        let memeTextAttributes:[String: Any] = [
            NSAttributedStringKey.strokeColor.rawValue: UIColor.white,
            NSAttributedStringKey.foregroundColor.rawValue: UIColor.black,
            NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSAttributedStringKey.strokeWidth.rawValue: UIColor.red
        ]
        
        topText.text = "TOP"
        bottomText.text = "BOTTOM"
        
        topText.delegate = self
        bottomText.delegate = self
        
        topText.typingAttributes = memeTextAttributes
        bottomText.typingAttributes = memeTextAttributes

    }
    
    @IBAction func pickAnImage(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        let paragraphStyleToCenterText = NSMutableParagraphStyle()
        paragraphStyleToCenterText.alignment = NSTextAlignment.center
        
        let memeTextAttributes: [String: Any] = [
            NSAttributedStringKey.strokeColor.rawValue : UIColor.black,
            NSAttributedStringKey.foregroundColor.rawValue : UIColor.white,
            NSAttributedStringKey.font.rawValue : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSAttributedStringKey.strokeWidth.rawValue : -3.0,
            
            NSAttributedStringKey.paragraphStyle.rawValue : paragraphStyleToCenterText
            ]
        
        textField.text = ""
        if textField == topText{
            view.frame.origin.y = 0
        }
        
        textField.defaultTextAttributes = memeTextAttributes
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        topText.adjustsFontSizeToFitWidth = true
        bottomText.adjustsFontSizeToFitWidth = true
        subscribeToKeybordNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unsubscribeToKeybordNotification()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            imagePickerView.image = image
        }
        dismiss(animated: true, completion: nil)
        
    }
    
    @objc func keybordWillShow(_ notification: Notification){
        if bottomText.isFirstResponder{
            view.frame.origin.y = -getKeybordHeight(notification)
        }
    }
    
    @objc func keybordWillHide(_ notification: Notification){
        
        if bottomText.isFirstResponder{
            view.frame.origin.y = 0
        }
        
    }
    
    func getKeybordHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyBordSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyBordSize.cgRectValue.height
        
    }
    
    @IBAction func cameraAction(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func subscribeToKeybordNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(keybordWillShow(_:)),
                                               name: .UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keybordWillHide(_:)),
                                               name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeToKeybordNotification(){
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    @IBAction func shareImageButton(_ sender: UIBarButtonItem) {
        
        // image to share
        let image = generateMemedImage()
        
        // set up activity view controller
        let imageToShare = [ image ]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func generateMemedImage() -> UIImage {
        
        topToolbar.isHidden = true
        bottomToolbar.isHidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        topToolbar.isHidden = false
        bottomToolbar.isHidden = false
        
        
        return memedImage
    }
    @IBAction func cancelEdit(_ sender: UIBarButtonItem){
        dismiss(animated: true, completion: nil)
    }
    
}

