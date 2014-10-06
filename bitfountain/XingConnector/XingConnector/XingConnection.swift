//
//  XingConnection.swift
//  XingConnector
//
//  Created by Orestis Salinger on 06.10.14.
//  Copyright (c) 2014 Orestis Salinger. All rights reserved.



import UIKit

protocol XingApiProtocol {
    func didRecieveResponse(results: NSDictionary)
}

class XingConnection: NSObject {
    var data: NSMutableData = NSMutableData()
    var delegate: XingApiProtocol?
    //
    // visits: /v1/users/:user_id/visits
    var consumerKey = "adc70795cb5ef65405da"
    var consumerSecret = "f44c6af769e899516ca0d3e9fbae92b900f0fd07"
    
    var urlXing = "https://api.xing.com/v1/users/:Orestis_Salinger/visits"
    
    //Search iTunes
    func connect(token: String) {
        
        //Clean up the search terms by replacing spaces with +
//        var term = searchTerm.stringByReplacingOccurrencesOfString(" ", withString: "+",
//            options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
//        
        
        
        
//        var escapedSearchTerm = term //.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        
        
//        var urlPath = urlXing //"http://itunes.apple.com/search?term=\(escapedSearchTerm)&media=music"
        
        
//        var urlPathIMDB = "http://www.imdb.com/xml/find?json=1&nr=1&nm=on&q=\(term)"
        
        var url: NSURL = NSURL(string: urlXing)
        
        
        
        println("Search Xing API at URL \(urlXing)")
        
        var request: NSURLRequest = NSURLRequest(URL: url)
        
        println("Request: \(request)")
        
        
        var connection: NSURLConnection = NSURLConnection(request: request, delegate: self,startImmediately: false)
        
        
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
   
        let jsonObject : AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil)
        
        println("JSon: \(jsonObject)\n\n\n\n\n\n\n\n\n\n\n\n\n")
        
        
        if let desc: AnyObject = (((jsonObject as? NSArray)?[0] as? NSDictionary)?["description"] as? NSDictionary)?["description"]{
            println("Description: \(desc)")
            
            
        }
        
        
        
        
        delegate?.didRecieveResponse(jsonObject as NSDictionary)
    }
    
    
    
    
    func authenticate(){
        // set up the base64-encoded credentials
        let username = "user"
        let password = "pass"
        let loginString = NSString(format: "%@:%@", username, password)
        let loginData: NSData = loginString.dataUsingEncoding(NSUTF8StringEncoding)!
        let base64LoginString = loginData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.fromMask(0))
        
        // create the request
        let url = NSURL(string: self.urlXing)
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        // fire off the request
        // make sure your class conforms to NSURLConnectionDelegate
        let urlConnection = NSURLConnection(request: request, delegate: self)
        
    }
    
    
    
    
    
    
}

