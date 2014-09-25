//
//  ViewController.swift
//  Postcard
//
//  Created by Orestis Salinger on 21.09.14.
//  Copyright (c) 2014 Orestis Salinger. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var nameText: UITextField!
    
    @IBOutlet weak var messageText: UITextField!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    @IBAction func hideLabel(sender: AnyObject) {
        if(messageLabel.hidden==false){
            messageLabel.hidden = true
        }
    }


    @IBAction func sendMailPressed(sender: UIButton) {
        
        // Code will evaluate when pressing send mail button.
        messageLabel.hidden = false
        
        
        messageLabel.text = "Sending Email To \(nameText.text) \n\(messageText.text)"
        
        
        messageLabel.textColor = UIColor.redColor()

        messageLabel.backgroundColor = UIColor.grayColor()
        
        sender.backgroundColor = UIColor.yellowColor()
        
        sender.tintColor = UIColor.blueColor()
        
        sender.setTitle("Mail Sent", forState: UIControlState.Normal)
        
        nameText.text = "\u{1F496}"
        messageText.text = "\u{24}"
        
        nameText.resignFirstResponder()
        messageText.resignFirstResponder()
    }
  
}

