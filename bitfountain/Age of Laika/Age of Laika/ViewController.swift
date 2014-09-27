//
//  ViewController.swift
//  Age of Laika
//
//  Created by Orestis Salinger on 27.09.14.
//  Copyright (c) 2014 Orestis Salinger. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textFieldHumanYears: UITextField!
   
    @IBOutlet weak var labelDogYears: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        textFieldHumanYears.becomeFirstResponder()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func ButtonConvertToDogYearsPressed(sender: UIButton) {
        if(isInputInvalid()){
            showInvalidInputWarning()
            return
        }
        setColors()
        labelDogYears.text = "\(textFieldHumanYears.text) Years For A Human\n\nAre \(calculateHumanToDogYears()) Years For A Dog"
    }
    
    @IBAction func ButtonConvertToRealDogYearsPressed(sender: UIButton) {
        if(isInputInvalid()){
            showInvalidInputWarning()
            return
        }
        setColors()
        labelDogYears.text = "\(textFieldHumanYears.text) Years For A Human\n\nAre \(calculateHumanToRealDogYears()) Real Years For A Dog"
    
    }
    
    
    func convertTextInputToInt() ->Int{
        var textInputHumanYears = textFieldHumanYears.text
        var textNumberToInt = textInputHumanYears.toInt()
        var optionalToInt = textNumberToInt!
        return optionalToInt
    }
    
    func setColors(){
        labelDogYears.textColor = UIColor.blueColor()

    }
    
    func calculateHumanToDogYears() ->Int{
        return convertTextInputToInt() * 7
    }
    
    func calculateHumanToRealDogYears() ->Int{
        var input = convertTextInputToInt()
        if(input <= 2){
            return convertTextInputToInt() * 7
        }else {
            return (input - 2) * 7 + 21
        }
    }

    
    
    func isInputInvalid() ->Bool{
        return textFieldHumanYears.text.isEmpty
    }
    
    func showInvalidInputWarning(){
        labelDogYears.textColor = UIColor.redColor()
        labelDogYears.text = "Please enter a valid number."

    }
    
    func request(){
        let url = NSURL(string: "http://myrestservice")
        let theRequest = NSURLRequest(URL: url)
        
        NSURLConnection.sendAsynchronousRequest(theRequest, queue: nil, completionHandler: {(response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            if data.length > 0 && error == nil {
                let response : AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.fromMask(0), error: nil)
            }
        })
    }


}

