//
//  FeedPageViewController.swift
//  Automaya
//
//  Created by jmvarguez on 7/10/15.
//  Copyright (c) 2015 jmvarguez. All rights reserved.
//


import UIKit

class FeedPageViewController: UIViewController {
    
    @IBOutlet var textView: UITextView!
    @IBOutlet weak var myWebView: UIWebView!
    
    var selectedFeedTitle = String()
    var selectedFeedFeedContent = String()
    var selectedFeedURL = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        var feedContent:String! = "<h3>\(selectedFeedTitle)</h3>\(selectedFeedFeedContent)"
        myWebView.loadHTMLString(feedContent, baseURL: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if segue.identifier == "openWebPage" {
            
            let fwpvc: FeedWebPageViewController = segue.destinationViewController as! FeedWebPageViewController
            selectedFeedURL =  selectedFeedURL.stringByReplacingOccurrencesOfString(" ", withString:"")
            selectedFeedURL =  selectedFeedURL.stringByReplacingOccurrencesOfString("\n", withString:"")
            fwpvc.feedURL = selectedFeedURL
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
