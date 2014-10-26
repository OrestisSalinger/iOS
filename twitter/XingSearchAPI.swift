//
//  ITunesSearchAPI.swift
//  WebServiceConnector
//
//  Created by Orestis Salinger on 27.09.14.
//  Copyright (c) 2014 Orestis Salinger. All rights reserved.
//

import UIKit

protocol XingSearchAPIProtocol {
    func didRecieveResponse(results: [VisitorData])
}

class XingSearchAPI: NSObject {
    var data: NSMutableData = NSMutableData()
    var visitorDatas:[VisitorData] = []

    var delegate: XingSearchAPIProtocol?
    
    func searchXingFor(searchTerm: String) {
        //Clean up the search terms by replacing spaces with +
        var itunesSearchTerm = searchTerm.stringByReplacingOccurrencesOfString(" ", withString: "+",
            options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
        var escapedSearchTerm = itunesSearchTerm //.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        var urlPath = "http://itunes.apple.com/search?term=\(escapedSearchTerm)&media=music"
        var urlPathIMDB = "http://www.imdb.com/xml/find?json=1&nr=1&nm=on&q=\(itunesSearchTerm)"
        var url: NSURL = NSURL(string: urlPathIMDB)!
        println("Search iTunes API at URL \(urlPath)")
        var request: NSURLRequest = NSURLRequest(URL: url)
        println("Request: \(request)")
        var connection: NSURLConnection = NSURLConnection(request: request, delegate: self,startImmediately: false)!
        println("...........Starting connection")
        connection.start()
        println("...........Connection has started")
    }
    
    //NSURLConnection delegate method
    func connection(connection: NSURLConnection!, didFailWithError error: NSError!) {
        println("Failed with error:\(error.localizedDescription)")
    }
    
    //NSURLConnection delegate method
    func connection(didReceiveResponse: NSURLConnection!, didReceiveResponse response: NSURLResponse!) {
        //New request so we need to clear the data object
        self.data = NSMutableData()
        println("...........connection(didReceiveResponse) \ndataLength: \(self.data.length)")
    }
    
    //NSURLConnection delegate method
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!) {
        //Append incoming data
        self.data.appendData(data)
        println("...........connection(didReceiveData)")
        
    }
    
    //NSURLConnection delegate method
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        //Finished receiving data and convert it to a JSON object
        var err: NSError
        //        var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data,
        //            options:NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
        
        let jsonObject : AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil)
        
        println("JSon: \(jsonObject)\n\n\n\n\n\n\n\n\n\n\n\n\n")
        
        if let desc: AnyObject = (((jsonObject as? NSArray)?[0] as? NSDictionary)?["description"] as? NSDictionary)?["description"]{
            println("Description: \(desc)")
        }
        
        delegate?.didRecieveResponse(self.extractVisitorsFromDict(jsonObject as NSDictionary))
    }
    
    func extractVisitorsFromDict(results: NSDictionary)-> [VisitorData]{
        var visitorDatas:[VisitorData] = []
        if results.count > 0 {
            let dict = results as Dictionary<String, AnyObject>
            let visits : AnyObject? = dict["visits"]
            let collection = visits! as Array<Dictionary<String, AnyObject>>
            for visit in collection {
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
            }
        }
        println("Last visitor: \(visitorDatas[0])")
        return visitorDatas
    }
    
    func filterReason(reason: AnyObject)->String{
        if (reason.lowercaseString.rangeOfString("talentmanager") != nil) {
            return "Talentmanager"
        }else if (reason.lowercaseString.rangeOfString("contacts/recommendations") != nil) {
            return "Recommended by XING"
        }
        return ""
    }
       
}

