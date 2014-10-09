//
//  ViewController.swift
//  OAuth4Json
//
//  Created by Orestis Salinger on 06.10.14.
//  Copyright (c) 2014 Orestis Salinger. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    let oauth_version = "1.0a"
    let authorization_header = false
    
    
    let settings = [
        "client_id": "cb963bc8cdcc350e230e",
        "client_secret": "c6bfe071646023eb133dc7cb84e7c5117084baaf",
        "authorize_uri": "https://api.xing.com/v1/authorize",
        "token_uri": "https://api.xing.com/v1/request_token",
        "access_token_url": "https://api.xing.com/v1/access_token",
    ]

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("I***********viewDidLoad")

        
        let oauth = OAuth2CodeGrant(settings: settings)

        
        oauth.onAuthorize = { parameters in
            println("Did authorize with parameters: \(parameters)")
        }
        oauth.onFailure = { error in        // `error` is nil on cancel
            if nil != error {
                println("Authorization went wrong: \(error!.localizedDescription)")
            }
        }
        let redir = "myapp://callback"        // don't forget to register this scheme
        let scope = "profile email"
        let web = oauth.authorizeEmbedded(redir, scope: scope, params: nil, from: self)
        oauth.afterAuthorizeOrFailure = { wasFailure in
            web.dismissViewControllerAnimated(true, completion: nil)
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

