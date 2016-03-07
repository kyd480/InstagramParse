//
//  LoadPhotoViewController.swift
//  InstagramParse
//
//  Created by Kevin Duong on 3/6/16.
//  Copyright © 2016 Kevin Duong. All rights reserved.
//

import UIKit

class LoadPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {


    @IBOutlet weak var displayImageView: UIImageView!
    let vc = UIImagePickerController()
    var myUploadedImage: UIImage?
    @IBOutlet weak var captionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        vc.delegate = self
        vc.allowsEditing = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCamera(sender: AnyObject) {
        vc.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    @IBAction func onUpload(sender: AnyObject) {
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    static let userDidUploadNotification = "userDidUpload"
    
    @IBAction func onSubmit(sender: AnyObject) {
        if myUploadedImage != nil {
            Post.postUserImage(myUploadedImage, withCaption: captionTextField.text, withCompletion: { (success, error) -> Void in
                if success == true {
                    print("successful upload")
                
                    NSNotificationCenter.defaultCenter().postNotificationName(LoadPhotoViewController.userDidUploadNotification, object: nil)
                } else {
                    print(error?.localizedDescription)
                }
            })
        }
    }
    
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            // Get the image captured by the UIImagePickerController
//            let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
            
            // Do something with the images (based on your use case)
            displayImageView.image = editedImage
            myUploadedImage = resize(editedImage, newSize: CGSize(width: editedImage.size.width/2, height: editedImage.size.height/2))
            
            // Dismiss UIImagePickerController to go back to your original view controller
            dismissViewControllerAnimated(true, completion: nil)
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
