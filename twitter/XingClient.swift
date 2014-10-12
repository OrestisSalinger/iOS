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
let request_token_path = "/v1/request_token"
let callback_url = "cptwitterdemo://authenticate/xing/"
let authorize_path = "https://api.xing.com/v1/authorize?oauth_token="
let access_token_path = "/v1/access_token"
let scope = "https://api.xing.com"

class XingClient: BDBOAuth1RequestOperationManager {
    var response:Array<Dictionary<String, AnyObject>>?
    var visitorDatas:[VisitorData] = []

    
    class var sharedInstance: XingClient {
        struct Static {
            static let instance = XingClient(baseURL: tBaseUrl, consumerKey: tConsumerKey, consumerSecret:tConsumerSecret)
            }
        return Static.instance
    }

    func removeAccessTokenIfGiven(){
        if(isAuthorized()){
            println("AccessToken already given:\(XingClient.sharedInstance.requestSerializer.accessToken.token)")
            XingClient.sharedInstance.requestSerializer.removeAccessToken()
        }else{
            println("No access token given so far.")
        }
    }
    
    func isAuthorized()->Bool{
        return XingClient.sharedInstance.requestSerializer.accessToken != nil
    }
    
    func login() {
        XingClient.sharedInstance.fetchRequestTokenWithPath(
            request_token_path,
            method: "GET",
            callbackURL: NSURL(string: callback_url),
            scope: scope,
            success: { (requestToken: BDBOAuthToken!) -> Void in
                println("Got the request token: \(requestToken)")
                var authUrl = NSURL(string: "\(authorize_path)\(requestToken.token)")
                UIApplication.sharedApplication().openURL(authUrl)
                println("Opened URL: \(authUrl)")})
            {(error: NSError!) -> Void in
                println("\n!!! Failed to get the request token!!!\n\n\n")
        }
    }
    

    
}