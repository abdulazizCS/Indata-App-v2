//
//  ViewController.swift
//  NDHpple
//
//  Created by IUPUI on 2/18/16.
//  Copyright © 2016 Nicolai Davidsson. All rights reserved.
//

import UIKit


var arrayOfTitles = [String]()
var arrayOfDates = [String]()
var arrayOfAuthors = [String]()
var arrayOfLinks = [String]()


class ViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var newsfeedTable: UITableView!
    
    var pageNumber:Int = 2
    
    var titlesArray = [String]()
    var datesArray = [String]()
    var authorsArray = [String]()
    var linksArray = [String]()
    


    @IBOutlet weak var showMoreButton: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func showMoreArticles(sender: AnyObject) {
        
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.showMoreArticles()
            self.refreshTable()
        }
        
        if (arrayOfTitles.count == 290){
            showMoreButton.hidden = true
        }
        
        print("Titles \(arrayOfTitles.count)")
        print("Authors \(arrayOfAuthors.count)")
        print("Dates \(arrayOfDates.count)")
    }
    
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.showNewsfeedArticles()
            self.refreshTable()
        }
    }

    override func viewDidDisappear(animated: Bool) {
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.resetNewsfeed()
            self.refreshTable()
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayOfTitles.count
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> TableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! TableViewCell

        let author = String(arrayOfAuthors[indexPath.row].characters.prefix(1)).uppercaseString + String(arrayOfAuthors[indexPath.row].characters.dropFirst())

        
        cell.articleTitleLabel?.text = "\(indexPath.row + 1). " + arrayOfTitles[indexPath.row]
        cell.articleDateLabel?.text = arrayOfDates[indexPath.row]
        cell.articleAuthorLabel?.text = "By: \(author)"
        
        
        return cell
    }

    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        
        
        rowCount = indexPath.row
        
        return indexPath
    }

    
    
    override func viewDidAppear(animated: Bool) {
    
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.showNewsfeedArticles()
            self.refreshTable()
        }

        print("Reloaded");
    }
    
    
    func showNewsfeedArticles() {
        
        if InternetConnection.isConnectedToNetwork().boolValue == true {
            
            NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: "http://www.eastersealstech.com/")!) { data, response, error in
                
                let html = NSString(data: data!, encoding: NSUTF8StringEncoding)
                let parser = NDHpple(HTMLData: html! as String)
                
                // Articles Titles
                let xpath = "//*[@id='main']/article/div/header/h1[@class='entry-title']/a"
                
                
                // Articles Categories
                //   let xpath3 = "//*[@id='main']/article/div/header/div/a"
                
                
                
                guard let titles = parser.searchWithXPathQuery(xpath) else { return }
                
                for node in titles {
                    
                    let title = (node.firstChild?.content!)!
                    
                    self.titlesArray.append(title)
                    
                    //print(self.titlesArray)
                    
                }
                
                NSUserDefaults.standardUserDefaults().setObject(self.titlesArray, forKey: "arrayOfTitles")
                
                
                //Publish dates
                let xpath1 = "//*[@id='main']/article/div/header/div[@class='entry-meta']/span[3]/a/time[@class='entry-date published']"
                
                guard let dates = parser.searchWithXPathQuery(xpath1) else { return }
                
                for node in dates {
                    
                    let date = node.firstChild?.content!
                    self.datesArray.append(date!)
                    
                    //print(self.datesArray)
                }
                
                NSUserDefaults.standardUserDefaults().setObject(self.datesArray, forKey: "arrayOfDates")
                
                
                
                //Articles Authors
                let xpath2 = "//*[@id='main']/article/div/header/div[@class='entry-meta']/span/span[@class='author vcard']/a"
                guard let authors = parser.searchWithXPathQuery(xpath2) else { return }
                
                for node in authors {
                    
                    let author = node.firstChild?.content!
                    self.authorsArray.append(author!)
                    
                    //print(self.authorsArray)
                }
                
                NSUserDefaults.standardUserDefaults().setObject(self.authorsArray, forKey: "arrayOfAuthors")
                
                
                
                //Articles Content
                let xpath3 = "//*[@class='entry-footer continue-reading']/a/@href"
                //let xpath3 = "//*[@class='entry-content']"
                
                guard let links = parser.searchWithXPathQuery(xpath3) else { return }
                
                for node in links {
                    
                    //let link = node.raw
                    let link = node.firstChild?.content!
                    self.linksArray.append(link!)
                    
                }
                
                
                //print(self.linksArray.count)
                
                NSUserDefaults.standardUserDefaults().setObject(self.linksArray, forKey: "arrayOfLinks")
                
                
                }.resume()
            
        } else {
            print("There is no internet connection!")
            let alert = UIAlertView(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }
        
        
        if NSUserDefaults.standardUserDefaults().objectForKey("arrayOfTitles") != nil {
            
            arrayOfTitles = NSUserDefaults.standardUserDefaults().objectForKey("arrayOfTitles") as! [String]
        }
        
        if NSUserDefaults.standardUserDefaults().objectForKey("arrayOfDates") != nil {
            
            arrayOfDates = NSUserDefaults.standardUserDefaults().objectForKey("arrayOfDates") as! [String]
            
        }
        
        if NSUserDefaults.standardUserDefaults().objectForKey("arrayOfAuthors") != nil {
            
            arrayOfAuthors = NSUserDefaults.standardUserDefaults().objectForKey("arrayOfAuthors") as! [String]
            
        }
        
        
        if NSUserDefaults.standardUserDefaults().objectForKey("arrayOfLinks") != nil {
            
            arrayOfLinks = NSUserDefaults.standardUserDefaults().objectForKey("arrayOfLinks") as! [String]
            
        }

    }
    
    func showMoreArticles() {
        
        if InternetConnection.isConnectedToNetwork().boolValue == true {
            
            self.pageNumber++
            print(pageNumber)
            print(arrayOfTitles.count)
            NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: "http://www.eastersealstech.com/page/\(pageNumber)" )!) { data, response, error in
                
                let html = NSString(data: data!, encoding: NSUTF8StringEncoding)
                let parser = NDHpple(HTMLData: html! as String)
                
                // Articles Titles
                let xpath = "//*[@id='main']/article/div/header/h1[@class='entry-title']/a"
                
                
                // Articles Categories
                //   let xpath3 = "//*[@id='main']/article/div/header/div/a"
                
                
                
                guard let titles = parser.searchWithXPathQuery(xpath) else { return }
                
                for node in titles {
                    
                    let title = (node.firstChild?.content!)!
                    
                    self.titlesArray.append(title)
                    
                    //print(self.titlesArray)
                    
                }
                
                NSUserDefaults.standardUserDefaults().setObject(self.titlesArray, forKey: "arrayOfTitles")
                
                
                //Publish dates
                let xpath1 = "//*[@id='main']/article/div/header/div[@class='entry-meta']/span[3]/a/time[@class='entry-date published']"
                
                guard let dates = parser.searchWithXPathQuery(xpath1) else { return }
                
                for node in dates {
                    
                    let date = node.firstChild?.content!
                    self.datesArray.append(date!)
                    
                    //print(self.datesArray)
                }
                
                NSUserDefaults.standardUserDefaults().setObject(self.datesArray, forKey: "arrayOfDates")
                
                
                
                //Articles Authors
                let xpath2 = "//*[@id='main']/article/div/header/div[@class='entry-meta']/span/span[@class='author vcard']/a"
                guard let authors = parser.searchWithXPathQuery(xpath2) else { return }
                
                for node in authors {
                    
                    let author = node.firstChild?.content!
                    self.authorsArray.append(author!)
                    
                    //print(self.authorsArray)
                }
                
                NSUserDefaults.standardUserDefaults().setObject(self.authorsArray, forKey: "arrayOfAuthors")
                
                
                
                //Articles Content
                let xpath3 = "//*[@class='entry-footer continue-reading']/a/@href"
                //let xpath3 = "//*[@class='entry-content']"
                
                guard let links = parser.searchWithXPathQuery(xpath3) else { return }
                
                for node in links {
                    
                    //let link = node.raw
                    let link = node.firstChild?.content!
                    self.linksArray.append(link!)
                    
                }
                
                
                //print(self.linksArray.count)
                
                NSUserDefaults.standardUserDefaults().setObject(self.linksArray, forKey: "arrayOfLinks")
                
                
                }.resume()
            
            
            
        } else {
            print("There is no internet connection!")
            let alert = UIAlertView(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }
        
        
        
        if NSUserDefaults.standardUserDefaults().objectForKey("arrayOfTitles") != nil {
            
            arrayOfTitles = NSUserDefaults.standardUserDefaults().objectForKey("arrayOfTitles") as! [String]
        }
        
        if NSUserDefaults.standardUserDefaults().objectForKey("arrayOfDates") != nil {
            
            arrayOfDates = NSUserDefaults.standardUserDefaults().objectForKey("arrayOfDates") as! [String]
            
        }
        
        if NSUserDefaults.standardUserDefaults().objectForKey("arrayOfAuthors") != nil {
            
            arrayOfAuthors = NSUserDefaults.standardUserDefaults().objectForKey("arrayOfAuthors") as! [String]
            
        }
        
        
        if NSUserDefaults.standardUserDefaults().objectForKey("arrayOfLinks") != nil {
            
            arrayOfLinks = NSUserDefaults.standardUserDefaults().objectForKey("arrayOfLinks") as! [String]
            
        }

        
        
    }

    
    func refreshTable()
    {
        dispatch_async(dispatch_get_main_queue(), {
            self.newsfeedTable.reloadData()
            return
        })
    }
    
    func resetNewsfeed() {
        
        arrayOfTitles = [String]()
        arrayOfDates = [String]()
        arrayOfAuthors = [String]()
        sarrayOfLinks = [String]()
        
        titlesArray = [String]()
        datesArray = [String]()
        authorsArray = [String]()
        linksArray = [String]()
        
        
        
        
        if NSUserDefaults.standardUserDefaults().objectForKey("arrayOfTitles") != nil {
            
            arrayOfTitles = NSUserDefaults.standardUserDefaults().objectForKey("arrayOfTitles") as! [String]
        }
        
        if NSUserDefaults.standardUserDefaults().objectForKey("arrayOfDates") != nil {
            
            arrayOfDates = NSUserDefaults.standardUserDefaults().objectForKey("arrayOfDates") as! [String]
            
        }
        
        if NSUserDefaults.standardUserDefaults().objectForKey("arrayOfAuthors") != nil {
            
            arrayOfAuthors = NSUserDefaults.standardUserDefaults().objectForKey("arrayOfAuthors") as! [String]
            
        }
        
        
        if NSUserDefaults.standardUserDefaults().objectForKey("arrayOfLinks") != nil {
            
            arrayOfLinks = NSUserDefaults.standardUserDefaults().objectForKey("arrayOfLinks") as! [String]
            
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
