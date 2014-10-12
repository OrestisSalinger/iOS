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
            println(" count: \(visitorDatas.count)")
        var visitorDatasLocal:[VisitorData] = []
        var visit: VisitorData = VisitorData()
        
        if(visitorDatas.count > 0){
            visitorDatasLocal = visitorDatas
            visit = visitorDatas[indexPath.row]//.removeAtIndex(0)
            println("image url: \(visit.photoURL)" )
            
            
            cell = tableView.dequeueReusableCellWithIdentifier("visitorCell") as XingVisitorCell
            cell.name.text = visit.name
            cell.companyName.text = visit.companyName
            cell.reason.text = visit.reason
            cell.visitCount.text = visit.visitCount
            cell.visitDate.text = visit.visitDate

            
            let url = NSURL.URLWithString(visit.photoURL);
            var err: NSError?
            var imageData :NSData = NSData.dataWithContentsOfURL(url,options: NSDataReadingOptions.DataReadingMappedIfSafe, error: &err)
            var image = UIImage(data:imageData)
            cell.visitorPicture.image = image
            if(indexPath.row%2 != 0) {
                cell.backgroundColor = UIColor.grayColor()
            }
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