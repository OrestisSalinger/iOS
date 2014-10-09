//
//  TwitterClient.swift
//  Twitter
//
//  Created by Orestis Salinger on 09.10.14.
//  Copyright (c) 2014 Orestis Salinger. All rights reserved.
//

import UIKit
let tConsumerKey = "0d9ae6b97c933d027942"
let tConsumerSecret = "f1d457ed7b97f1dfa525f41d991eed7b9d712aed"
let tBaseUrl = NSURL(string: "https://api.xing.com")

class TwitterClient: BDBOAuth1RequestOperationManager {
       class var sharedInstance: TwitterClient {
            struct Static {
                static let instance = TwitterClient(baseURL: tBaseUrl, consumerKey: tConsumerKey, consumerSecret:tConsumerSecret)
            }
        return Static.instance
    }

}