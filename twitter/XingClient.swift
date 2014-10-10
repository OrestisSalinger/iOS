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

class XingClient: BDBOAuth1RequestOperationManager {
    var response:AnyObject?

    class var sharedInstance: XingClient {
        struct Static {
            static let instance = XingClient(baseURL: tBaseUrl, consumerKey: tConsumerKey, consumerSecret:tConsumerSecret)
            }
        return Static.instance
    }
    
    
    func loginWithBlock(){
        if isAuthorized() {
            removeAccessToken()
        }
        authorize(fetchRequestToken())
    }
    
    func authorize(token: BDBOAuthToken){
        var stringToken = token.token
        var authUrl = NSURL(string: "https://api.xing.com/v1/authorize?oauth_token=\(stringToken)")
        UIApplication.sharedApplication().openURL(authUrl)
    }
    
    
    func fetchRequestToken()-> BDBOAuthToken{
        var token = BDBOAuthToken();
        XingClient.sharedInstance.fetchRequestTokenWithPath(
            "/v1/request_token",
            method: "GET",
            callbackURL: NSURL(string: "cptwitterdemo://authenticate/xing/"),
            scope: "https://api.xing.com",
            success: { (requestToken: BDBOAuthToken!) -> Void in
                println("Got the request token: \(requestToken)")
                token = requestToken
            })
            { (error: NSError!) -> Void in
                println("\n!!! Failed to get the request token!!!\n\n\n")
        }
        return token
    }
    
    func removeAccessToken(){
        println("AccessToken already given:\(XingClient.sharedInstance.requestSerializer.accessToken.token)")
        XingClient.sharedInstance.requestSerializer.removeAccessToken()
    }
    
    func isAuthorized()->Bool{
        return XingClient.sharedInstance.requestSerializer.accessToken != nil
    }

    
}