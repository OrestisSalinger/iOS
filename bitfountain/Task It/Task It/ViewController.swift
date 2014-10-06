//
//  ViewController.swift
//  Task It
//
//  Created by Orestis Salinger on 05.10.14.
//  Copyright (c) 2014 Orestis Salinger. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ITunesSearchAPIProtocol {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var api: ITunesSearchAPI = ITunesSearchAPI()
    var tableData: NSArray = NSArray()
    var imageCache = NSMutableDictionary()
    let searchDefault = "Orestis"
    

    var artistDatas:[ArtistData] = []
    
        override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
         api.delegate = self;
        
        
        api.searchItunesFor(searchDefault)

        println("Searching for \(searchDefault)...")
        
    }
    @IBAction func searchButtonPressed(sender: UIButton) {
//        self.tableView.delegate = self
//        self.tableView.dataSource = self
//        api.delegate = self;
        var searchTerm = self.searchTextField.text
        
        api.searchItunesFor(searchTerm)
        
        println("Searching for \(searchTerm)...")
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func didRecieveResponse(results: NSDictionary) {
        println("Received results")
        // Store the results in our table data array
                if results.count>0 {
                    
                    println("Results: \(results)")
                    
                    self.tableData = results["name_exact"] as NSArray
                    
                    for var i = 0; i < self.tableData.count; i++ {
                        var name:String = tableData[i]["name"] as String
                        var desc:String = tableData[i]["description"] as String
                        
                        println("Artist Name: \(name)")
                        println("desc: \(desc) \n......................\n")
                        
                        var artistData = ArtistData()
                        artistData.name = name
                        artistData.collectionName = desc
                        artistDatas.append(artistData)
                        
//                        println(artistData)
//                        println(artistDatas.count)
                        
                    }
                        self.tableView?.reloadData()

                }
    }

    
    
//    UITableViewDataSource
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = TaskCellTableViewCell();
        if(artistDatas.count > 0){
            println("************ artistDatas count: \(artistDatas.count)")
            println("Index: \(indexPath.row)")
            cell = tableView.dequeueReusableCellWithIdentifier("myCell") as TaskCellTableViewCell
                
                

            cell.taskLabel.text = artistDatas.removeAtIndex(0).name
            cell.descriptionLabel.text = artistDatas.removeAtIndex(0).collectionName
        
        
        if(indexPath.row%2 != 0) {
            cell.backgroundColor = UIColor.grayColor()
            
        }
        }
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        println("************ Table Rows: \(artistDatas.count)")
        return artistDatas.count
    }
//    UITableViewDelegate
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
    
    }
    

}

