//
//  QRCodeReader.swift
//  EEB3App
//
//  Created by Anirudhh Ramesh on 19/02/2018.
//  Copyright © 2018 RAMESH anirudhh. All rights reserved.
//

import UIKit
import AVFoundation
import SafariServices

class QRCodeReader: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    /*
    var video = AVCaptureVideoPreviewLayer()
    
    @IBOutlet weak var qrcodeimage: UIImageView!
    override func viewDidLoad() {
        
        //creating session
        let session = AVCaptureSession()
        
        //Define capture device
        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        do
        {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            session.addInput(input)
            
        }
        catch
        {
            print("ERROR")
        }
        
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        output.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        
        video = AVCaptureVideoPreviewLayer(session: session)
        video.frame = view.layer.bounds
        view.layer.addSublayer(video)
        
        self.view.bringSubview(toFront: qrcodeimage)
        session.startRunning()
    }
    
    func captureOutput(_ output: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        if metadataObjects != nil && metadataObjects.count != 0
        {
            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject
            {
                if object.type == AVMetadataObjectTypeQRCode
                {
                    let urlLink = URL(string: object.stringValue)
                    let alert = UIAlertController(title: "QR Code", message: object.stringValue, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Rescan for QR codes", style: .default, handler: nil))
                    alert.addAction(UIAlertAction(title: "Open link", style: .default, handler: { (nil) in
                        let svc = SFSafariViewController(url: urlLink!)
                        self.present(svc, animated: true, completion: nil)
                    }))
                    alert.addAction(UIAlertAction(title: "Copy", style: .default, handler: { (nil) in
                        UIPasteboard.general.string = object.stringValue
                    }))
                    
                    present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    */
}
