//
//  TwitterClient.swift
//  Twitter
//
//  Created by Orestis Salinger on 09.10.14.
//  Copyright (c) 2014 Orestis Salinger. All rights reserved.
//

import UIKit
let tConsumerKey = "c571770851588f4748f6"
let tConsumerSecret = "7b1510d4a3bef9599110fbb4b730948db8932592"
let tBaseUrl = NSURL(string: "https://api.xing.com")

class TwitterClient: BDBOAuth1RequestOperationManager {
       class var sharedInstance: TwitterClient {
            struct Static {
                static let instance = TwitterClient(baseURL: tBaseUrl, consumerKey: tConsumerKey, consumerSecret:tConsumerSecret)
            }
        return Static.instance
    }

}