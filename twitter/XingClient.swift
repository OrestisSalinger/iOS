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
        println("LOGGING IN")
        if XingClient.sharedInstance.requestSerializer.requestToken == nil{
            println("NO REQUEST TOKEN GIVEN")
            removeAccessTokenIfGiven()
        XingClient.sharedInstance.fetchRequestTokenWithPath(
            request_token_path,
            method: "GET",
            callbackURL: NSURL(string: callback_url),
            scope: scope,
            success: { (requestToken: BDBOAuthToken!) -> Void in
                println("Got the request token: \(requestToken)")
                var authUrl = NSURL(string: "\(authorize_path)\(requestToken.token)")
                UIApplication.sharedApplication().openURL(authUrl!)
                println("Opened URL: \(authUrl)")})
            {(error: NSError!) -> Void in
                println("\n!!! Failed to get the request token!!!\n\n\n")
        }
        }
    }
    
    
    
    func persist(visitor: VisitorData)->Bool{
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(visitor.name, forKey: "lastXingVisitor.name")
        userDefaults.setObject(visitor.visitDate, forKey: "lastXingVisitor.visitDate")

        //        userDefaults.synchronize()
        return true
    }
    
    func readLastVisitorFromFS()-> String{
        var result:String = ""
        if let userDefaults = NSUserDefaults.standardUserDefaults() as NSUserDefaults?{
            if let visitorName : AnyObject = userDefaults.objectForKey("lastXingVisitor.name"){
                let vn: AnyObject = visitorName
                if let visitorDate : AnyObject = userDefaults.objectForKey("lastXingVisitor.visitDate"){
                    result = "\(vn)_\(visitorDate)"
                }
            }
        }
        return result
    }

    func extractVisitorsFromDict(results: NSDictionary)-> [VisitorData]{
        var visitorDatas:[VisitorData] = []
        if results.count > 0 {
            let dict = results as Dictionary<String, AnyObject>
            let visits : AnyObject? = dict["visits"]
            let collection = visits! as Array<Dictionary<String, AnyObject>>
            for visit in collection {
                if isDataGiven(visit){
                    visitorDatas.append(extractToVisitorData(visit))
                }else {
                    visitorDatas.append(extractDateToDummyVisitorData(visit))
                }
            }
        }
        if(!isPersisted()){
            persist(visitorDatas[0])
        }else{
            if isNewLastVisitor(visitorDatas[0]){
                persist(visitorDatas[0])
                println("New Last Visitor \(visitorDatas[0].name)")
            }else{
                println("No New Last Visitor \(visitorDatas[0].name)")
            }
        }
        return visitorDatas
    }

    func extractToVisitorData(visit: Dictionary<String, AnyObject>) -> VisitorData{
        let display_name : AnyObject? = visit["display_name"]
        let company_name : AnyObject? = visit["company_name"]
        var reason : AnyObject? = visit["reason"]?["text"]
        let photo_medium_url : AnyObject? = visit["photo_urls"]?["maxi_thumb"]
        let visited_at : AnyObject? = visit["visited_at"]
        let visit_count : AnyObject! = visit["visit_count"]
        var data = VisitorData()
        reason = filterReason(reason!)
        data.name = display_name as String
        data.companyName = company_name as String
        data.visitDate = visited_at as String
        data.reason = reason as String
        data.visitCount = "\(visit_count)"
        data.photoURL = photo_medium_url as String
        visitorDatas.append(data)
        return data
    }

    func extractDateToDummyVisitorData(visit: Dictionary<String, AnyObject>) -> VisitorData{
        let dummyString = "Not a Member."
        let visited_at : AnyObject? = visit["visited_at"]
        var data = VisitorData()
        data.name = dummyString
        data.companyName = ""
        data.visitDate = visited_at as String
        data.reason = ""
        data.visitCount = ""
        data.photoURL = ""
        visitorDatas.append(data)
        return data
    }
    
    func isPersisted() -> Bool{
        return readLastVisitorFromFS() != ""
    }
    
    func isNewLastVisitor(data: VisitorData)-> Bool{
        println("IS NEW FS: \(readLastVisitorFromFS())" )
        println("IS NEW FS: \(data.name)_\(data.visitDate)" )

        return readLastVisitorFromFS() != "\(data.name)_\(data.visitDate)"
    }
    
    func isDataGiven(visit: AnyObject)-> Bool{
        return (visit["display_name"] as NSObject != NSNull())
    }
    
    func filterReason(reason: AnyObject)->String{
        if(reason as NSObject == NSNull()){
            return ""
        }
        if (reason.lowercaseString.rangeOfString("talentmanager") != nil) {
            return "Talentmanager"
        }else if (reason.lowercaseString.rangeOfString("contacts/recommendations") != nil) {
            return "Recommended by XING"
        }else{
            return reason as String
        }
    }
    
    func refresh(){
        println("XING CLIENT REFRESHING")
        self.GET("/v1/users/orestis_salinger/visits", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response:AnyObject!) -> Void in
            let dict = response as Dictionary<String, AnyObject>
            let visits : AnyObject? = dict["visits"]
            let vc = LoginViewController(nibName: "LoginView", bundle: nil)
            vc.didRecieveResponse(XingClient.sharedInstance.extractVisitorsFromDict(dict as NSDictionary))
            
            }, failure: { (operation: AFHTTPRequestOperation!,error: NSError!) -> Void in
                println("Error: \(error)")
        })
    
    }
}