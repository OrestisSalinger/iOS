//
//  AppDelegate.swift
//  Twitter
//
//  Created by Orestis Salinger on 09.10.14.
//  Copyright (c) 2014 Orestis Salinger. All rights reserved.
//

import UIKit
import CoreData
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var newVisitor: Bool = false
    var isBackGroundActive: Bool = false
    var lastVisitor: VisitorData?
    var visitorDatas:[VisitorData] = []
    var timer:NSTimer!
    var urlXing:NSURL!
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
//            ENTRY_LOG()
        
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
        isBackGroundActive = true
        
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        println("++++++++++++++ applicationDidEnterBackground isBackGround: \(isBackGroundActive)")
//        if isBackGroundActive {
//            timer = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
//        }
        
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

    }

  
    
    func applicationWillEnterForeground(application: UIApplication) {
        println("++++++++++++++ applicationWillEnterForeground")
//        isBackGroundActive = false
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        if timer != nil{
            timer.invalidate()
            if(XingClient.sharedInstance.isNewVisit){
                println("++++++++++++++ NOW SENDING WELCOME MESSAGE...")
                askUserForSendingMessage()
            }
            
        }
        println("++++++++++++++ applicationDidBecomeActive")

        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(applicationWillTerminate: UIApplication) {
        println("++++++++++++++ applicationWillTerminate")

        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String, annotation: AnyObject?) -> Bool {
            println("+++++++++++++ application openURL \(url)")
            self.urlXing = url
            connectToXing(url)
        return true
    }
    
    // MARK: - Context Management
//    
//    lazy var managedObjectContext: NSManagedObjectContext? = {
//        // Returns the managed object context for the application (which is already bound to the persistent store
//        // coordinator for the application.) This property is optional since there are legitimate error
//        // conditions that could cause the creation of the context to fail.
//        let coordinator = self.persistentStoreCoordinator
//        if coordinator == nil {
//            return nil
//        }
//        var managedObjectContext = NSManagedObjectContext()
//        managedObjectContext.persistentStoreCoordinator = coordinator
//        return managedObjectContext
//        }()
//    
//
//    
//    // MARK: - Core Data stack
//    
//    lazy var applicationDocumentsDirectory: NSURL = {
//        // The directory the application uses to store the Core Data store file. This code uses a directory named "eu.salingers.ios.net.Visitors_for_XING" in the application's documents Application Support directory.
//        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
//        return urls[urls.count-1] as NSURL
//        }()
//    
//    lazy var managedObjectModel: NSManagedObjectModel = {
//        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
//        let modelURL = NSBundle.mainBundle().URLForResource("VisitorsForXing", withExtension: "mom")!
//        return NSManagedObjectModel(contentsOfURL: modelURL)!
//        }()
//    
//    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
//        // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
//        // Create the coordinator and store
//        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
//        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("VisitorsForXing.sqlite")
//        var error: NSError? = nil
//        var failureReason = "There was an error creating or loading the application's saved data."
//        if coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil, error: &error) == nil {
//            coordinator = nil
//            // Report any error we got.
//            let dict = NSMutableDictionary()
//            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
//            dict[NSLocalizedFailureReasonErrorKey] = failureReason
//            dict[NSUnderlyingErrorKey] = error
//            error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
//            // Replace this with code to handle the error appropriately.
//            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//            NSLog("Unresolved error \(error), \(error!.userInfo)")
//            abort()
//        }
//        
//        return coordinator
//        }()
//    
//    // MARK: - Core Data Saving support
//    
//    func saveContext () {
//        if let moc = self.managedObjectContext {
//            var error: NSError? = nil
//            if moc.hasChanges && !moc.save(&error) {
//                // Replace this implementation with code to handle the error appropriately.
//                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                NSLog("Unresolved error \(error), \(error!.userInfo)")
//                abort()
//            }
//        }
//    }
//    
    
    
    
    
    
    
    func connectToXing(url: NSURL) ->Bool{
        
        
        println("Connecting to Xing.")
        if XingClient.sharedInstance.requestSerializer.accessToken != nil {
            println("\n\nACCESS TOKEN ALREADY EXIST\n\n")
            XingClient.sharedInstance.GET("/v1/users/orestis_salinger/visits", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response:AnyObject!) -> Void in
                let dict = response as Dictionary<String, AnyObject>
                let visits : AnyObject? = dict["visits"]
                let vc = LoginViewController(nibName: "LoginView", bundle: nil)
                println(response)
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
    func update() {
        println("TIMER EVENT")
        if XingClient.sharedInstance.isNewVisit {
            askUserForSendingMessage()
            connectToXing(urlXing)
        }
    }
    
    func askUserForSendingMessage (){
        var localNotification:UILocalNotification = UILocalNotification()
        localNotification.alertAction = "Send Message..."
        localNotification.alertBody = "New visitor on XING: \(XingClient.sharedInstance.visitorDatas[0].name)"
        localNotification.fireDate = NSDate(timeIntervalSinceNow: 0)
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }
    
    
    
}

