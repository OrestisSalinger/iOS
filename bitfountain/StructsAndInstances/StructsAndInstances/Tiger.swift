//
//  Tiger.swift
//  StructsAndInstances
//
//  Created by Orestis Salinger on 28.09.14.
//  Copyright (c) 2014 Orestis Salinger. All rights reserved.
//

import Foundation
import UIKit

struct Tiger {
    var age = 0
    var name = ""
    var breed = ""
    var image = UIImage(named:"")
    let facts:[String] = ["The tiger is the biggest cat.","Tigers can reach a length of 3.3 meters.","A group of tigers is known as 'ambush' or 'streak.'"]
    
    func chuff(){
        println("\(self.name): Chuff Chuff")
    }
    func chuffNumberOfTimes(numberOfTimes: Int){
        for var chuff = 0; chuff<numberOfTimes; ++chuff {
            self.chuff();
        }
    }

    func chuffNumberOfTimes(numberOfTimes: Int, isLoud: Bool){
        for var chuff = 1; chuff<=numberOfTimes; chuff++ {
            if isLoud{
             self.chuff()
            }
            else {
                println("\(self.name): purr, purr")
            }
        }
    }

    func ageInTigerYears(regularAge: Int) -> Int{
        return regularAge * 3
    }

    
    func randomFact() -> String{
        return facts[Int(arc4random_uniform(UInt32(3)))]
    }
    
    
    
    
    

}







