//
//  ITunesSearchAPI.swift
//  WebServiceConnector
//
//  Created by Orestis Salinger on 27.09.14.
//  Copyright (c) 2014 Orestis Salinger. All rights reserved.
//

import UIKit

protocol ITunesSearchAPIProtocol {
    func didRecieveResponse(results: NSDictionary)
}

class ITunesSearchAPI: NSObject {
    var data: NSMutableData = NSMutableData()
    var delegate: ITunesSearchAPIProtocol?
    
    //Search iTunes
    func searchItunesFor(searchTerm: String) {
        
        //Clean up the search terms by replacing spaces with +
        var itunesSearchTerm = searchTerm.stringByReplacingOccurrencesOfString(" ", withString: "+",
            options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
        
        
        
        
        var escapedSearchTerm = itunesSearchTerm //.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        var urlPath = "http://itunes.apple.com/search?term=\(escapedSearchTerm)&media=music"
        var url: NSURL = NSURL(string: urlPath)
        println("Search iTunes API at URL \(urlPath)")
        var request: NSURLRequest = NSURLRequest(URL: url)
        println("Request: \(request)")
        var connection: NSURLConnection = NSURLConnection(request: request, delegate: self,
        startImmediately: false)
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
        
//        println("JSon: \(jsonObject.allValues)\n\n\n\n\n\n\n\n\n\n\n\n\n")

        
        if let name = (((jsonObject as? NSArray)?[1] as? NSDictionary)?["artistName"] as? NSDictionary)?["name"]{
            println("Name: \(name)")

        
        }
        
        
        
        
        delegate?.didRecieveResponse(jsonObject as NSDictionary)
    }
    
}

