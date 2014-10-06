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
    override func viewDidLoad() {
        super.viewDidLoad()
        CROAuth2Client.clientWithPresentingController(self)

        
        self.client.retrieveAuthToken({ (authToken) -> Void in
        
            if let optionnalAuthToken = authToken {
                println("Received access token: " + authToken!)
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

