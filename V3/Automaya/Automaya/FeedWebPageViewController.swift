//
//  FeedWebPageViewController.swift
//  Automaya
//
//  Created by jmvarguez on 7/10/15.
//  Copyright (c) 2015 jmvarguez. All rights reserved.
//
/*
var postLink: String = String()

Now update viewDidLoad function with following lines of code

override func viewDidLoad() {

super.viewDidLoad()

let url: NSURL = NSURL(string: postLink)

let request: NSURLRequest = NSURLRequest(URL: url)

webView.loadRequest(request)

webView.delegate = self
*/

import UIKit

class FeedWebPageViewController: UIViewController {
    
       @IBOutlet var myWebView: UIWebView!
    
    
    var feedURL: String = String()
    

    override func viewDidLoad() {
        super.viewDidLoad()
       // myWebView.loadRequest(NSURLRequest(URL: NSURL(string: feedURL)!))
       // myWebView.loadRequest(NSURLRequest(URL: NSURL(string: feedURL)!))
        
        let stringWithPossibleURL: String = feedURL // Or another source of text
         println(stringWithPossibleURL)
        if let validURL: NSURL = NSURL(string: stringWithPossibleURL) {
            // Successfully constructed an NSURL; open it
           // UIApplication.sharedApplication().openURL(validURL)
            
            let url: NSURL = NSURL(string: feedURL)!
            let request: NSURLRequest = NSURLRequest(URL: url)
            myWebView.loadRequest(request)
        } else {
            // Initialization failed; alert the user
            let controller: UIAlertController = UIAlertController(title: "URL INVALIDA", message: "No se puede cargar la pagina", preferredStyle: .Alert)
            controller.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            
            self.presentViewController(controller, animated: true, completion: nil)
        }
        
       
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
