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
    @IBOutlet weak var nameLabel: UILabel!

    
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
        nameLabel.hidden = false
        
        nameLabel.text = nameText.text
        messageLabel.text = messageText.text

        nameLabel.textColor = UIColor.blueColor()
        messageLabel.textColor = UIColor.greenColor()
 //       messageLabel.backgroundColor = UIColor.blackColor()
        
        sender.backgroundColor = UIColor.yellowColor()
        
        sender.tintColor = UIColor.blueColor()
        
        sender.setTitle("Mail Sent", forState: UIControlState.Normal)
        
        nameText.text = "\u{1F496}"
        messageText.text = "\u{24}"
        
        nameText.resignFirstResponder()
        messageText.resignFirstResponder()
    }
  
}

