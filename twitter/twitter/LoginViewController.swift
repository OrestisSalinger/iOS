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
        
        
        
        
        
    }
    
    @IBAction func onLogin(sender: AnyObject) {
        println("********** onLogin")
        xingClient.removeAccessTokenIfGiven()
        xingClient.login()
        
        let vc2 = ViewController(nibName: "TableView", bundle: nil)
        
        
        navigationController?.pushViewController(vc2, animated: true)
        
        

    }
    
    func didRecieveResponse(results: NSDictionary) {
//        println("\n\n\nReceived results:\n")
        if results.count > 0 {
            println("Results: \(results)")

            let dict = results as Dictionary<String, AnyObject>
            
            let visits : AnyObject? = dict["visits"]
            let collection = visits! as Array<Dictionary<String, AnyObject>>
            
            for visit in collection {
                let display_name : AnyObject? = visit["display_name"]
                let company_name : AnyObject? = visit["company_name"]
                var reason : AnyObject? = visit["reason"]?["text"]
                let photo_medium_url : AnyObject? = visit["photo_urls"]?["large"]
                let visited_at : AnyObject? = visit["visited_at"]
                let visit_count : AnyObject! = visit["visit_count"]
                
                var data = VisitorData()
                
                if (reason?.lowercaseString.rangeOfString("talentmanager") != nil) {
                    reason = "Talentmanager"
                }
                
                
                
                data.name = display_name as String
                data.companyName = company_name as String
                data.visitDate = visited_at as String
                data.reason = reason as String
                data.visitCount = "\(visit_count)"
                data.photoURL = photo_medium_url as String
                visitorDatas.append(data)
            }

            
            xingClient.visitorDatas = self.visitorDatas

            println(" \n......................\nxingClient.visitorDatas count: \(xingClient.visitorDatas.count)")
            
            
            
                        
        }
        
       
    }

    @IBOutlet weak var nav: UINavigationItem!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}