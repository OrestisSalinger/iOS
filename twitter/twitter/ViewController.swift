//
//  ViewController.swift
//  Twitter
//
//  Created by Orestis Salinger on 09.10.14.
//  Copyright (c) 2014 Orestis Salinger. All rights reserved.
//
//  Additional Sources:

//TODO checkout https://github.com/xing/XNGOAuth1Client/tree/master/XNGOAuth1Client
//as done with BDBOAuth1Manager in http://www.sososwift.com/posts/swift-programming-ios-app-basic-twitter-oauth-walkthrough or https://github.com/xing/XNGAPIClient







import UIKit

let oauth_version = "1.0a"
let request_token_path = "/v1/request_token"
let callback_url = "cptwitterdemo://authenticate/xing/"
let authorize_path = "https://api.xing.com/v1/authorize?oauth_token="

let access_token_path = "/v1/access_token"
let authorization_header = false
let scope = "https://api.xing.com"


class ViewController: UIViewController {
       override func viewDidLoad() {
        if(XingClient.sharedInstance.requestSerializer.accessToken != nil){
            println("AccessToken already given:\(XingClient.sharedInstance.requestSerializer.accessToken.token)")
            XingClient.sharedInstance.requestSerializer.removeAccessToken()
        }else{
            println("No access token given so far.")
        }
        


        super.viewDidLoad()

    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    
    @IBAction func onLogin(sender: UIButton) {
        //TODO
//        TwitterClient.sharedInstance.loginWithBlock()
//        goto next screen
           XingClient.sharedInstance.fetchRequestTokenWithPath(
            request_token_path,
            method: "GET",
            callbackURL: NSURL(string: callback_url),
            scope: scope,
            success: { (requestToken: BDBOAuthToken!) -> Void in
                println("Got the request token: \(requestToken)")
                var authUrl = NSURL(string: "\(authorize_path)\(requestToken.token)")
                UIApplication.sharedApplication().openURL(authUrl)
                
            })
            { (error: NSError!) -> Void in
                println("\n!!! Failed to get the request token!!!\n\n\n")
            }
    }
}



