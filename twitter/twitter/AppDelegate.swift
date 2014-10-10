//
//  AppDelegate.swift
//  Twitter
//
//  Created by Orestis Salinger on 09.10.14.
//  Copyright (c) 2014 Orestis Salinger. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String, annotation: AnyObject?) -> Bool {
        
        XingClient.sharedInstance.fetchAccessTokenWithPath(
                            "/v1/access_token",
                            method: "POST",
                            requestToken: BDBOAuthToken(queryString: url.query),
            success: { (accessToken: BDBOAuthToken! ) -> Void in
                            println("Got the access token: \(accessToken)")
                            XingClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
                            XingClient.sharedInstance.GET("/v1/users/orestis_salinger/visits", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response:AnyObject!) -> Void in
                                XingClient.sharedInstance.response = response

                                let dict = response as Dictionary<String, AnyObject>
                                
                                println("Dict: \(dict)")
                                
                                let visits : AnyObject? = dict["visits"]
                                
                                let collection = visits! as Array<Dictionary<String, AnyObject>>
                               
                                for visit in collection {
                                    let display_name : AnyObject? = visit["display_name"]
                                    let company_name : AnyObject? = visit["company_name"]
                                    let reason : AnyObject? = visit["reason"]?["text"]
                                    let photo_medium_url : AnyObject? = visit["photo_urls"]?["medium_thumb"]
                                    let visited_at : AnyObject? = visit["visited_at"]
                                    
                                    println("_______________\n\nName: \(display_name!)")
                                    println("Company: \(company_name!)")
                                    println("Picture: \(photo_medium_url!)")
                                    println("Date: \(visited_at!)")
                                    println("Reason: \(reason!)\n_______________\n\n")
                                }
                    }, failure: { (operation: AFHTTPRequestOperation!,error: NSError!) -> Void in
                                println("Error: \(error)")
                            })
                
                
                
                        })
                        { (error: NSError!) -> Void in
                                println("Failed to get the access token \(error)")
                        }
        
            return true
    }
    
    func jsonResponse() -> [String : AnyObject] {
        let path = NSBundle.mainBundle().pathForResource("data", ofType: "json")
        let data = NSData.dataWithContentsOfFile(path!, options: NSDataReadingOptions.DataReadingUncached, error: nil)
        
        let json: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil)
        return json as [String : AnyObject]
    }

    

}

