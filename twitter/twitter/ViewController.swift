//
//  ViewController.swift
//  Twitter
//
//  Created by Orestis Salinger on 09.10.14.
//  Copyright (c) 2014 Orestis Salinger. All rights reserved.
//
import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let xingClient = XingClient.sharedInstance
    var api: XingSearchAPI = XingSearchAPI()
    var tableData: NSArray = NSArray()
    var visitorDatas:[VisitorData] = []
    var response:Array<Dictionary<String, AnyObject>>?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("********** onTableView")
//        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "visitorCell")

        
        visitorDatas = xingClient.visitorDatas
    }



    //    UITableViewDataSource
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = XingVisitorCell();
        var visitorDatasLocal:[VisitorData] = []
        var visit: VisitorData = VisitorData()
        
        if(visitorDatas.count > 0){
            visitorDatasLocal = visitorDatas
            visit = visitorDatas[indexPath.row]
            cell = tableView.dequeueReusableCellWithIdentifier("visitorCell") as XingVisitorCell
            cell.name.text = visit.name
            cell.companyName.text = visit.companyName
            cell.reason.text = visit.reason
            cell.visitCount.text = visit.visitCount + ". visit"
            cell.visitDate.text = "on " + visit.visitDate
            var url:NSURL
            if(!visit.photoURL.isEmpty){
                url = NSURL.URLWithString(visit.photoURL);
            }else{
                url = NSURL.URLWithString("http://us.tintin.com/wp-content/uploads/2011/10/characters-rastapopoulos-sm.jpg");
                
            }
            var err: NSError?
            var imageData :NSData = NSData.dataWithContentsOfURL(url,options: NSDataReadingOptions.DataReadingMappedIfSafe, error: &err)
            var image = UIImage(data:imageData)
            cell.visitorPicture.image = image
            
        }
        return cell
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println("************ Table Rows: \(response)")
        return visitorDatas.count
    }
    
    //    UITableViewDelegate
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}