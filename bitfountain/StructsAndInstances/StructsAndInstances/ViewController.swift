//
//  ViewController.swift
//  StructsAndInstances
//
//  Created by Orestis Salinger on 28.09.14.
//  Copyright (c) 2014 Orestis Salinger. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bckgrdImageView: UIImageView!
    
    @IBOutlet weak var breedLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var ageLabel: UILabel!
    
    @IBOutlet weak var randomFact: UILabel!
    
    var tigers:[Tiger] = []

    var currentIndex = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var tiger = Tiger()
        tiger.name = "Tigger"
        tiger.age = 1
        tiger.breed = "bengal"
        tiger.image = UIImage(named: "BengalTiger.jpg")
        tiger.age = tiger.ageInTigerYears(tiger.age)
        setTiger(tiger)

        
        var tiger2 = Tiger()
        tiger2.name = "Indie"
        tiger2.age = 2
        tiger2.breed = "indochinese"
        tiger2.image = UIImage(named: "IndochineseTiger.jpg")
        tiger2.age = tiger2.ageInTigerYears(tiger2.age)

        var tiger3 = Tiger()
        tiger3.name = "Kleptor"
        tiger3.age = 3
        tiger3.breed = "malayan"
        tiger3.image = UIImage(named: "MalayanTiger.jpg")
        tiger3.age = tiger3.ageInTigerYears(tiger3.age)

        var tiger4 = Tiger()
        tiger4.name = "Buster"
        tiger4.age = 4
        tiger4.breed = "sibirian"
        tiger4.image = UIImage(named: "SiberianTiger.jpg")
        tiger4.age = tiger4.ageInTigerYears(tiger4.age)

        
        tigers += [tiger,tiger2,tiger3,tiger4]
        

    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func nextBarButtonItemPressed(sender: UIBarButtonItem) {
        var randomIndex = Int(arc4random_uniform(UInt32(tigers.count)))
        
        while currentIndex == randomIndex{
            randomIndex = Int(arc4random_uniform(UInt32(tigers.count)))
        }
        currentIndex = randomIndex;
        
        self.setTiger(tigers[randomIndex])
        
    }
    
    func setTiger(tiger: Tiger){
        UIView.transitionWithView(self.view, duration: 1, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {
            
            self.bckgrdImageView.image = tiger.image
            self.nameLabel.text = tiger.name
            self.ageLabel.text = "is \(tiger.age) years old."
            self.breedLabel.text = "He is a \(tiger.breed) tiger."
            self.randomFact.text = tiger.randomFact()
            
            }, completion:{ (finished: Bool) -> () in
        })
        
        
        if(currentIndex%2==0){
            tiger.chuffNumberOfTimes(3, isLoud: false)
        }
        else{
            tiger.chuffNumberOfTimes(3, isLoud: true)
        }
    
    }

}

