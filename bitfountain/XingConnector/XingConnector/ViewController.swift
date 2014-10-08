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
//    var xingConnection = XingConnection()
//    var client:CROAuth2Client = CROAuth2Client(baseURL: "https://api.xing.com/")
    let settings = [
        "client_id":"my_swift_app",
        "client_secret": "C7447242-A0CF-47C5-BAC7-B38BA91970A9",
        "authorize_uri": "https://authorize.smartplatforms.org/authorize",
        "token_uri":"https://authorize.smartplatforms.org/token"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let oauth = OAuth2CodeGrant(settings: settings)
       
        
        oauth.onAuthorize = { parameters in
            println("Did authorize with parameters: \(parameters)")
        }
        oauth.onFailure = { error in        // `error` is nil on cancel
            if nil != error {
                println("Authorization went wrong: \(error!.localizedDescription)")
            }
        }
        
        
        
//        CROAuth2Client.clientWithPresentingController(self)
//
//        
//        self.client.retrieveAuthToken({ (authToken) -> Void in
//        
//            if let optionnalAuthToken = authToken {
//                println("Received access token: " + authToken!)
//                self.xingConnection.connect(authToken!);
//
//            }
//        
//        })
        
        
    
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func didRecieveResponse(results: NSDictionary){
        
    }

}

