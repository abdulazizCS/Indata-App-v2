//
//  SearchResultsViewController.swift
//  Indata App V2
//
//  Created by IUPUI on 2/24/16.
//  Copyright © 2016 Nicolai Davidsson. All rights reserved.
//

import UIKit

var sarrayOfTitles = [String]()
var sarrayOfDates = [String]()
var sarrayOfAuthors = [String]()
var sarrayOfLinks = [String]()

class SearchResultsViewController: UIViewController, UITableViewDelegate {

    var stitlesArray = [String]()
    var sdatesArray = [String]()
    var sauthorsArray = [String]()
    var slinksArray = [String]()
    
    @IBOutlet weak var resultsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "\(query)"
        
        self.loadSearchResults()

        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            
        }

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(animated: Bool) {

      //  self.resultsTable.con
        self.resultsTable.reloadData()


    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sarrayOfTitles.count
        
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> SearchResultsTableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! SearchResultsTableViewCell
        
        //let author = String(sarrayOfAuthors[indexPath.row].characters.prefix(1)).uppercaseString + String(sarrayOfAuthors[indexPath.row].characters.dropFirst())
        
            cell.searchResultArticleLabel?.text = sarrayOfTitles[indexPath.row]

        
        //cell.sarticleDateLabel?.text = sarrayOfDates[indexPath.row]

        
        return cell
    }
    
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        
        
        //rowCount1 = indexPath.row
        
        return indexPath
    }
    
    
    
    func loadSearchResults(){
        
        print("Working!!!!!")
        

        if InternetConnection.isConnectedToNetwork().boolValue == true {
            
            NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: "http://www.eastersealstech.com/?s=" + query)!) { data, response, error in
                
                let html = NSString(data: data!, encoding: NSUTF8StringEncoding)
                let parser = NDHpple(HTMLData: html! as String)
                
                // Articles Titles
                let xpath = "//*[@id='main']/article/div/header/h1[@class='entry-title']/a"
                
                
                
                guard let titles = parser.searchWithXPathQuery(xpath) else { return }
                
                for node in titles {
                    
                    let title = (node.firstChild?.content!)!
                    
                    self.stitlesArray.append(title)
                    
                    
                }
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in

                
                print(self.stitlesArray)
                
                NSUserDefaults.standardUserDefaults().setObject(self.stitlesArray, forKey: "sarrayOfTitles")
                
                    
                })


                
                
                //Publish dates
                let xpath1 = "//*[@id='main']/article/div/header/div[@class='entry-meta']/span[3]/a/time[@class='entry-date published']"
                
                guard let dates = parser.searchWithXPathQuery(xpath1) else { return }
                
                for node in dates {
                    
                    let date = node.firstChild?.content!
                    self.sdatesArray.append(date!)
                    
                    //print(self.sdatesArray)
                }
                
               // dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    
                    NSUserDefaults.standardUserDefaults().setObject(self.sdatesArray, forKey: "sarrayOfDates")
               // })
               
                
                
                
                //Articles Authors
                let xpath2 = "//*[@id='main']/article/div/header/div[@class='entry-meta']/span/span[@class='author vcard']/a"
                guard let authors = parser.searchWithXPathQuery(xpath2) else { return }
                
                for node in authors {
                    
                    let author = node.firstChild?.content!
                    self.sauthorsArray.append(author!)
                    
                    //print(self.sauthorsArray)
                }
                
                //dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    
                    NSUserDefaults.standardUserDefaults().setObject(self.sauthorsArray, forKey: "sarrayOfAuthors")
                //})
              
                
                
                
                //Articles Content
                let xpath3 = "//*[@class='entry-footer continue-reading']/a/@href"
                //let xpath3 = "//*[@class='entry-content']"
                
                guard let links = parser.searchWithXPathQuery(xpath3) else { return }
                
                for node in links {
                    
                    //let link = node.raw
                    let link = node.firstChild?.content!
                    self.slinksArray.append(link!)
                    
                }
                
                
                //print(self.linksArray.count)
               //dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                    NSUserDefaults.standardUserDefaults().setObject(self.slinksArray, forKey: "sarrayOfLinks")
               // })

                
                
                }.resume()
            
            
        } else {
            print("There is no internet connection!")
            let alert = UIAlertView(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }
        
        if NSUserDefaults.standardUserDefaults().objectForKey("sarrayOfTitles") != nil {
            
            sarrayOfTitles = NSUserDefaults.standardUserDefaults().objectForKey("sarrayOfTitles") as! [String]
            print("Done!!!!")
        }
        
        if NSUserDefaults.standardUserDefaults().objectForKey("sarrayOfDates") != nil {
            
            sarrayOfDates = NSUserDefaults.standardUserDefaults().objectForKey("sarrayOfDates") as! [String]
            
        }
        
        if NSUserDefaults.standardUserDefaults().objectForKey("sarrayOfAuthors") != nil {
            
            sarrayOfAuthors = NSUserDefaults.standardUserDefaults().objectForKey("sarrayOfAuthors") as! [String]
            
        }
        
        
        if NSUserDefaults.standardUserDefaults().objectForKey("sarrayOfLinks") != nil {
            
            sarrayOfLinks = NSUserDefaults.standardUserDefaults().objectForKey("sarrayOfLinks") as! [String]
            
        }

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
