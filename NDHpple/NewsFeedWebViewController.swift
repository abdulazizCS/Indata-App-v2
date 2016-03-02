//
//  NewsFeedWebViewController.swift
//  Indata App V2
//
//  Created by IUPUI on 2/20/16.
//  Copyright © 2016 Nicolai Davidsson. All rights reserved.
//

import UIKit

var rowCount:Int = 0

class NewsFeedWebViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = arrayOfTitles[rowCount]
       // self.title.
        
        let url = NSURL(string: arrayOfLinks[rowCount])
        
        webView.loadRequest(NSURLRequest(URL: url!))
        //webView.loadHTMLString(arrayOfLinks[rowCount], baseURL: nil)
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
