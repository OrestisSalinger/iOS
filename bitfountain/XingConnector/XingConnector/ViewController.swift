//
//  ViewController.swift
//  XingConnector
//
//  Created by Orestis Salinger on 06.10.14.
//  Copyright (c) 2014 Orestis Salinger. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

//    var client = CROAuth2Client(baseURL: "https://api.xing.com/v1/users/:Orestis_Salinger/visits")
    
    var xingConnection = XingConnection()
    
    var client:CROAuth2Client = CROAuth2Client(baseURL: "https://api.xing.com/")
    var consumerKey = "0d9ae6b97c933d027942"
    var consumerSecret = "f1d457ed7b97f1dfa525f41d991eed7b9d712aed"
    
    var baseUrl = "https://api.xing.com"
    var requestTokenPath = "/v1/request_token"
    var accessTokenPath = "/v1/access_token"
    var authorizePath = "/v1/authorize"
    
    
    let settings = [
        "client_id":"0d9ae6b97c933d027942",
        "client_secret": "f1d457ed7b97f1dfa525f41d991eed7b9d712aed",
        "authorize_uri": "https://api.xing.com/v1/authorize",
        "token_url": "https://api.xing.com/v1/access_token",
        ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let oauth = OAuth2CodeGrant(settings: settings)

        
        oauth.onAuthorize = { parameters in
            println("Did authorize with parameters: \(parameters)")
        }
        println("*************************  \(settings)")

        oauth.onFailure = { error in        // `error` is nil on cancel

            if nil != error {
                println("Authorization went wrong: \(error!.localizedDescription)")
            }
        }
        

        
        CROAuth2Client.clientWithPresentingController(self)

        
        self.client.retrieveAuthToken({ (authToken) -> Void in
        
            if let optionnalAuthToken = authToken {
                println("Received access token: " + optionnalAuthToken)
                self.xingConnection.connect(authToken!);

            }
        
        })
        

    
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func didRecieveResponse(results: NSDictionary){
        
    }

}

