//
//  Balloon.swift
//  99 Red Balloons
//
//  Created by Orestis Salinger on 05.10.14.
//  Copyright (c) 2014 Orestis Salinger. All rights reserved.
//

import Foundation
import UIKit

struct Balloon {
    var id = 0
    var image = UIImage(named:"")
    
    
    
    func randomImageNumber(value: Int) -> Int{
        return Int(arc4random_uniform(UInt32(value))) + 1
    }
    
}







