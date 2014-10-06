//
//  CRCredentialsHelper.swift
//  GetThere
//
//  Created by Clement Rousselle on 8/24/14.
//  Copyright (c) 2014 Clement Rousselle. All rights reserved.
//

import Foundation

class CRCredentialsHelper : NSObject 
{
    
   
    var oauth_version = "1.0a"
    var request_token_url = "https://api.xing.com/v1/request_token"
    var authorize_url = "https://api.xing.com/v1/authorize"
    var access_token_url = "https://api.xing.com/v1/access_token"
    var authorization_header = false

    
    class func sharedInstance() -> CRCredentialsHelper {
        
        struct Instance {
            static let credentialsHelper = CRCredentialsHelper()
        }
        
        return Instance.credentialsHelper
    }
    
    func baseURL() -> String {
        //TODO: ADD YOUR VALUE HERE
        return "https://api.xing.com/"
    }
 
    func authorizeURL() -> String {
        //TODO: ADD YOUR VALUE HERE
        return authorize_url
    }
    
    func tokenURL() -> String {
        //TODO: ADD YOUR VALUE HERE
        return access_token_url
    }
    
    func redirectURI() -> String {
        //TODO: ADD YOUR VALUE HERE
        return ""
    }
    
    func clientID() -> String {
        //TODO: ADD YOUR VALUE HERE
        return "cb963bc8cdcc350e230e"
    }
    
    func clientSecret() -> String {
        //TODO: ADD YOUR VALUE HERE
        return "c6bfe071646023eb133dc7cb84e7c5117084baaf"
    }
}
