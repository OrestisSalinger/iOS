//
//  FeedItem.swift
//  ExchangeAGram
//
//  Created by Orestis Salinger on 19.10.14.
//  Copyright (c) 2014 Orestis Salinger. All rights reserved.
//

import Foundation
import CoreData

class FeedItem: NSManagedObject {

    @NSManaged var caption: String
    @NSManaged var image: NSData

}
