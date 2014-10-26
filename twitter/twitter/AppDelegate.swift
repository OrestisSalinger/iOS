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
    var newVisitor: Bool = false
    var lastVisitor: VisitorData?
    var visitorDatas:[VisitorData] = []
    var timer:NSTimer!
    var urlXing:NSURL!
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        if(UIApplication.instancesRespondToSelector(Selector("registerUserNotificationSettings:")))
        {
            application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: UIUserNotificationType.Sound | UIUserNotificationType.Alert | UIUserNotificationType.Badge, categories: nil))
        }
        else
        {
            //do iOS 7 stuff, which is pretty much nothing for local notifications.
        }
        return true
    }
    
    
    
    func applicationWillResignActive(application: UIApplication) {
        println("++++++++++++++ applicationWillResignActive")

        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        println("++++++++++++++ applicationDidEnterBackground")
//        App enters background now
//        TODO: implement counter functionallity for calling 
        
        
        timer = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
        
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func update() {
        println("TIMER EVENT")
        if XingClient.sharedInstance.isNewVisit{
            var localNotification:UILocalNotification = UILocalNotification()
            localNotification.alertAction = "Send Message..."
            localNotification.alertBody = "New visitor on XING: \(XingClient.sharedInstance.visitorDatas[0].name)"
            localNotification.fireDate = NSDate(timeIntervalSinceNow: 0)
            UIApplication.sharedApplication().scheduleLocalNotification(localNotification)

        
        }
        
        
        
        connectToXing(urlXing)

    }
    
    
    func applicationWillEnterForeground(application: UIApplication) {
        println("++++++++++++++ applicationWillEnterForeground")
        
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        if timer != nil{
            timer.invalidate()
        }
        println("++++++++++++++ applicationDidBecomeActive")

        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(applicationWillTerminate: UIApplication) {
        println("++++++++++++++ applicationDidBecomeActive")

        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String, annotation: AnyObject?) -> Bool {
        println("++++++++++++++ application")
        self.urlXing = url
        connectToXing(url)
        
        return true
    }
    
    func connectToXing(url: NSURL) ->Bool{
        println("Connecting to Xing.")
        if XingClient.sharedInstance.requestSerializer.accessToken != nil {
            
//            let requestToken: BDBOAuthToken = XingClient.sharedInstance.requestSerializer.requestToken
            
            
//            let accessToken: BDBOAuthToken = XingClient.sharedInstance.requestSerializer.accessToken

            
            println("\n\nACCESS TOKEN ALREADY EXIST\n\n")
            XingClient.sharedInstance.GET("/v1/users/orestis_salinger/visits", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response:AnyObject!) -> Void in
                let dict = response as Dictionary<String, AnyObject>
                let visits : AnyObject? = dict["visits"]
                let vc = LoginViewController(nibName: "LoginView", bundle: nil)
                vc.didRecieveResponse(XingClient.sharedInstance.extractVisitorsFromDict(dict as NSDictionary))
                }, failure: { (operation: AFHTTPRequestOperation!,error: NSError!) -> Void in
                    println("Error: \(error)")
            })


        }else{
            println("ACCESS TOKEN DOES NOT EXIST")

        XingClient.sharedInstance.fetchAccessTokenWithPath(
            "/v1/access_token",
            method: "POST",
            requestToken: BDBOAuthToken(queryString: url.query), success: { (accessToken: BDBOAuthToken! ) -> Void in
                println("Got the access token: \(accessToken)")
                XingClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
                XingClient.sharedInstance.GET("/v1/users/orestis_salinger/visits", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response:AnyObject!) -> Void in
                    let dict = response as Dictionary<String, AnyObject>
                    let visits : AnyObject? = dict["visits"]
                    let vc = LoginViewController(nibName: "LoginView", bundle: nil)
                    vc.didRecieveResponse(XingClient.sharedInstance.extractVisitorsFromDict(dict as NSDictionary))
                    }, failure: { (operation: AFHTTPRequestOperation!,error: NSError!) -> Void in
                        println("Error: \(error)")
                })
            })
            { (error: NSError!) -> Void in
                println("Failed to get the access token \(error)")
        }
        }
        return true
    }
    
    
    
}

