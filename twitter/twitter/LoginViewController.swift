//
//  LoginViewController
//  Twitter
//
//  Created by Orestis Salinger on 09.10.14.
//  Copyright (c) 2014 Orestis Salinger. All rights reserved.
//
import UIKit

class LoginViewController: UIViewController, XingSearchAPIProtocol{
    
    @IBOutlet weak var visitButton: UIButton!
    
    
    let xingClient = XingClient.sharedInstance
    var api: XingSearchAPI = XingSearchAPI()
    var visitorDatas:[VisitorData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        println("VIEW DID LOAD")
        onLogin(UIButton())
    }
    
    
    @IBAction func onLogin(sender: AnyObject) {
        println("********** onLogin")
        xingClient.login()
        println("********** Logged in")
        
        let vc2 = ViewController(nibName: "TableView", bundle: nil)
        navigationController?.pushViewController(vc2, animated: true)
        

    }
    
    func didRecieveResponse(visitorDatas:[VisitorData]) {
        println("********** didRecieveResponse")

        self.visitorDatas = visitorDatas
        xingClient.visitorDatas = self.visitorDatas
        
        
        
    }
    
   
    @IBOutlet weak var nav: UINavigationItem!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}