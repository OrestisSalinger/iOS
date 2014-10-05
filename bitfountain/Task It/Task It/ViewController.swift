//
//  ViewController.swift
//  Task It
//
//  Created by Orestis Salinger on 05.10.14.
//  Copyright (c) 2014 Orestis Salinger. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ITunesSearchAPIProtocol {

    @IBOutlet weak var tableView: UITableView!
    var api: ITunesSearchAPI = ITunesSearchAPI()
    var tableData: NSArray = NSArray()
    var imageCache = NSMutableDictionary()
    
    var artistNames:[String] = []
    var collectionCensoredName:[String] = []
    var collectionPrice:[Float32] = []

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
         api.delegate = self;
        api.searchItunesFor("Elvis")

        println("Searching for Elvis...")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func didRecieveResponse(results: NSDictionary) {
        println("Received results")

        
//        println("\(results) \n......................\n")
        
        // Store the results in our table data array
                if results.count>0 {
                    self.tableData = results["results"] as NSArray
                    
                    for var i = 0; i < tableData.count; i++ {
//                        artistId
//                        previewUrl
//
//
                        
                        
                        var name:String = tableData[i]["artistName"] as String
                        var collName:String = tableData[i]["collectionCensoredName"] as String
                        var price:Float32 = tableData[i]["collectionPrice"] as Float32

                        println("Artist Name: \(name) \n......................\n")
                        println("Collection Name: \(collName)")
                        println("Collection Price: \(price) \n......................\n")
                        

                        
                        artistNames.append(name)
                        collectionCensoredName.append(collName)
                        collectionPrice.append(price)
                        
                        
                        
                                          }
                        self.tableView?.reloadData()

                }
    }

    
    
//    UITableViewDataSource
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        println("Index: \(indexPath.row)")
        var cell: TaskCellTableViewCell = tableView.dequeueReusableCellWithIdentifier("myCell") as TaskCellTableViewCell
        
        cell.taskLabel.text = artistNames.removeAtIndex(0)
        cell.descriptionLabel.text = collectionCensoredName.removeAtIndex(0)
        
       var f = collectionPrice.removeAtIndex(0)
        
        cell.dateLabel.text = "\(f)"
        
        
        
        if(indexPath.row%2 != 0) {
            cell.backgroundColor = UIColor.grayColor()
            
        }
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artistNames.count
    }
//    UITableViewDelegate
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
    
    }
    

}

