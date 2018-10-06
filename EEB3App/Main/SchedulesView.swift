//
//  FirstViewController.swift
//  EEB3App
//
//  Created by RAMESH anirudhh on 06/08/17.
//  Copyright © 2017 RAMESH anirudhh. All rights reserved.
//

import UIKit

var data = UIImagePNGRepresentation(blankimage!)! as NSData
var blankimage = UIImage(named: "blankImage.png")
var ifScheduleText = UserDefaults.standard.object(forKey: "ScheduleVisible")

class SchedulesView: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myScheduleTitle: UILabel!
    @IBOutlet weak var myScheduleDescript: UILabel!
    @IBOutlet weak var CardView: CardView!
    
    @IBAction func importImageSchedule(_ sender: Any)
    {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePickerController.sourceType = .camera
                imagePickerController.allowsEditing = true
                self.present(imagePickerController, animated: true, completion: nil)
            } else {
                print("camera not available")
                let alertsocial = UIAlertController(title: "Camera not available", message: "We couldn't find a camera app on your device", preferredStyle: .alert)
                let actionsocial = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
                
                alertsocial.addAction(actionsocial)
                self.present(alertsocial, animated: true, completion: nil)
                
            }
            
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            imagePickerController.allowsEditing = true
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated:true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        let imageData:NSData = UIImagePNGRepresentation(image)! as NSData
        
        UserDefaults.standard.set(imageData, forKey: "savedImage")
        data = UserDefaults.standard.object(forKey: "savedImage") as! NSData
        myImageView.image = UIImage(data: data as Data)
        
        
        UserDefaults.standard.set("Schedule been uploaded", forKey: "ScheduleVisible")
        
        self.dismiss(animated: true, completion: nil)
    }

    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        myImageView.image = UIImage(data: data as Data)
        if let x = UserDefaults.standard.object(forKey: "ScheduleVisible") as? String
        {
            if x == "Schedule been uploaded"{
                //Hide the front view UI
                data = UserDefaults.standard.object(forKey: "savedImage") as! NSData
                myImageView.image = UIImage(data: data as Data)
            }
            else
            {
                
            }
        }
    }
}
