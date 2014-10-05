//
//  ViewController.swift
//  99 Red Balloons
//
//  Created by Orestis Salinger on 05.10.14.
//  Copyright (c) 2014 Orestis Salinger. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    let numberOfBalloons = 99;
    let imagePraefix = "RedBalloon"
    let imagePostfix = ".jpg"
    var balloons:[Balloon]=[]
    
    @IBOutlet weak var balloonData: UILabel!
    
//    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var imageView: UIImageView!

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: "BerlinTVTower.jpg")
        for var i=1; i<=numberOfBalloons; i++ {
            var balloon:Balloon = Balloon()
            balloon.id = i
            let imagePath = imagePraefix + "\(balloon.randomImageNumber(4))" + imagePostfix
            
            balloon.image = UIImage(named: imagePath)
            println("Appending Balloon: \(i) \(imagePath)")
            balloons.append(balloon)
            
        }
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func NextButtonPressed(sender: UIBarButtonItem) {
        println("Next Pressed")
        var ball0 = Balloon()
        var num = ball0.randomImageNumber(numberOfBalloons)
        var ball = balloons[num]
        setBalloon(ball)
    }

    func setBalloon(balloon: Balloon){
        UIView.transitionWithView(self.view, duration: 1, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {
            
            println(" \(balloon.id) .............")
            self.imageView.image = balloon.image
            self.balloonData.text = "Balloon number \(balloon.id)"
            
            }, completion:{ (finished: Bool) -> () in
        })
        
        
        
    }

    
    
}

