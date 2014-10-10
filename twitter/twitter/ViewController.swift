//
//  ViewController.swift
//  Twitter
//
//  Created by Orestis Salinger on 09.10.14.
//  Copyright (c) 2014 Orestis Salinger. All rights reserved.
//

import UIKit

let oauth_version = "1.0a"
let request_token_path = "/v1/request_token"
let authorize_path = "/v1/authorize"
let access_token_path = "/v1/access_token"
let authorization_header = false



class ViewController: UIViewController {
       override func viewDidLoad() {
//        println("1 AccessToken:\(TwitterClient.sharedInstance.requestSerializer.accessToken.token)")

        super.viewDidLoad()
//        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
//        println("2 AccessToken:\(TwitterClient.sharedInstance.requestSerializer.accessToken.token)")

    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    //TODO checkout https://github.com/xing/XNGOAuth1Client/tree/master/XNGOAuth1Client
    //as done with BDBOAuth1Manager in http://www.sososwift.com/posts/swift-programming-ios-app-basic-twitter-oauth-walkthrough or https://github.com/xing/XNGAPIClient
    
    
    
    @IBAction func onLogin(sender: UIButton) {
        TwitterClient.sharedInstance.fetchRequestTokenWithPath(
            "/v1/request_token",
            method: "GET",
            callbackURL: NSURL(string: "cptwitterdemo://authenticate/xing/"),
            scope: "https://api.xing.com",
            success: { (requestToken: BDBOAuthToken!) -> Void in
                println("Got the request token: \(requestToken)")
                
                var authUrl = NSURL(string: "https://api.xing.com/v1/authorize?oauth_token=\(requestToken.token)")
                UIApplication.sharedApplication().openURL(authUrl)
                

                
            })
            { (error: NSError!) -> Void in
                println("\n!!! Failed to get the request token!!!\n\n\n")
            }
    }
}



