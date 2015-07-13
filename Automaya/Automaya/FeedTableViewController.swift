//
//  FeedTableViewController.swift
//  Automaya
//
//  Created by jmvarguez on 7/9/15.
//  Copyright (c) 2015 jmvarguez. All rights reserved.
//

import UIKit

class FeedTableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate, NSXMLParserDelegate {
    
    var myFeed : NSArray = []
    var url: NSURL = NSURL()
    
     @IBOutlet weak var menuButton:UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        // Cell height.
        self.tableView.rowHeight = 70
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "fondo"))
        
        // Set feed url. http://www.formula1.com/rss/news/latest.rss
        url = NSURL(string: "http://www.seminuevoscer.com.mx/condition/merida/feed/")!
        // Call custom function.
        loadRss(url);
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    func loadRss(data: NSURL) {
        // XmlParserManager instance/object/variable
        var myParser : XmlParserManager = XmlParserManager.alloc().initWithURL(data) as! XmlParserManager
        // Put feed in array
        myFeed = myParser.feeds
        
        tableView.reloadData()
    }
    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        /*
        if let newUrl = segue.destinationViewController as? NewFeedViewController {
            newUrl.onDataAvailable = {[weak self]
                (data) in
                if let weakSelf = self {
                    weakSelf.loadRss(data)
                }
            }
        }
            
        else if*/
if segue.identifier == "openPage" {
            
            var indexPath: NSIndexPath = self.tableView.indexPathForSelectedRow()!
            //let selectedFeedURL: String = feeds[indexPath.row].objectForKey("link") as String
            let selectedFTitle: String = myFeed[indexPath.row].objectForKey("title") as! String
            let selectedFContent: String = myFeed[indexPath.row].objectForKey("description") as! String
            let selectedFURL: String = myFeed[indexPath.row].objectForKey("link") as! String
            
            // Instance of our feedpageviewcontrolelr
            let fpvc: FeedPageViewController = segue.destinationViewController as! FeedPageViewController
            
            fpvc.selectedFeedTitle = selectedFTitle
            fpvc.selectedFeedFeedContent = selectedFContent
            fpvc.selectedFeedURL = selectedFURL
        }
    }
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return myFeed.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        
        if(indexPath.row % 2 == 0){
            
            cell.backgroundColor = UIColor.clearColor()
            
        } else {
            
            cell.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
            cell.textLabel?.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0)
            
        }
        
        // Feeds dictionary.
        var dict : NSDictionary! = myFeed.objectAtIndex(indexPath.row) as! NSDictionary
        
        // Set cell properties.
        cell.textLabel?.text = myFeed.objectAtIndex(indexPath.row).objectForKey("title") as? String
        
        cell.detailTextLabel?.text = myFeed.objectAtIndex(indexPath.row).objectForKey("pubDate") as? String
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
