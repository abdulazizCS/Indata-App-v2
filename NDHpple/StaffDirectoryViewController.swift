//
//  StaffDirectoryViewController.swift
//  NDHpple
//
//  Created by IUPUI on 2/20/16.
//  Copyright © 2016 Nicolai Davidsson. All rights reserved.
//

import UIKit


var arrayOfNames = [String]()
var arrayOfRoles = [String]()
var arrayOfPictures = [String]()
var arrayOfEmails = [String]()
var arrayOfBios = [String]()


class StaffDirectoryViewController: UIViewController, UITableViewDelegate {

    var namesArray = [String]()
    var picturesArray = [String]()
    var rolesArray = [String]()
    var emailsArray = [String]()
    var biosArray = [String]()
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if InternetConnection.isConnectedToNetwork().boolValue == true {
        
        NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: "http://www.eastersealstech.com/about/staff-directory/")!) { data, response, error in
            
            let html = NSString(data: data!, encoding: NSUTF8StringEncoding)
            let parser = NDHpple(HTMLData: html! as String)
            
            // Staff Names
            let xpath = "//*[@class='staffFluid indataStaffTitle']/strong"
            guard let names = parser.searchWithXPathQuery(xpath) else { return }
            
            for node in names {
                
                let name = node.firstChild?.content!
                
                self.namesArray.append(name!)
                
            }
            
            
            //print(self.namesArray)

            
            NSUserDefaults.standardUserDefaults().setObject(self.namesArray, forKey: "arrayOfNames")
            
            
            //Staff Roles
            let xpath1 = "//*[@class='staffFluid indataStaffTitle']/text()[normalize-space()]"

            guard let roles = parser.searchWithXPathQuery(xpath1) else { return }
            
            for node in roles {
                
                let role = node.content?.stringByReplacingOccurrencesOfString("\r\n        ", withString: "")
                
                self.rolesArray.append(role!)
                
            }
            
            
            //print(self.rolesArray)
            
            
            NSUserDefaults.standardUserDefaults().setObject(self.rolesArray, forKey: "arrayOfRoles")
            

            
            //Staff Pictures
            let xpath2 = "//*[@class='staffFluid indataStaffPic']/img/@src"
            
            guard let pictures = parser.searchWithXPathQuery(xpath2) else { return }
            
            for node in pictures {
                
                let picture = node.firstChild?.content!
                
                self.picturesArray.append(picture!)
                
            }
            
            
            //print(self.picturesArray)
            
            
            NSUserDefaults.standardUserDefaults().setObject(self.picturesArray, forKey: "arrayOfPictures")
            
            
            //Staff Emails
            let xpath3 = "//*[@class='staffFluid indataStaffTitle']/a"

            
            guard let emails = parser.searchWithXPathQuery(xpath3) else { return }
            
            for node in emails {
                
                let email = node.firstChild?.content!
                
                self.emailsArray.append(email!)
                
            }
            
            
            //print(self.emailsArray.count)
            
            
            NSUserDefaults.standardUserDefaults().setObject(self.emailsArray, forKey: "arrayOfEmails")
            
            
            //Staff Bios
            let xpath4 = "//*[@class='staffFluid indataStaffBio']"
            //let xpath4 = "//*[contains(@class, 'staffFluid indataStaffBio')]//text()"
            
            
            guard let bios = parser.searchWithXPathQuery(xpath4) else { return }
            
            for node in bios {
                
                let bio = node.raw
                
                self.biosArray.append(bio!)

            }
            
            
            //print(self.biosArray)
            //print(self.biosArray.count)
            
            NSUserDefaults.standardUserDefaults().setObject(self.biosArray, forKey: "arrayOfBios")
            

            
            }.resume()
        
        } else {
            print("There is no internet connection(staff directory)")
            
            let alert = UIAlertView(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }
        
        if NSUserDefaults.standardUserDefaults().objectForKey("arrayOfNames") != nil {
            
            arrayOfNames = NSUserDefaults.standardUserDefaults().objectForKey("arrayOfNames") as! [String]
        }
        
        if NSUserDefaults.standardUserDefaults().objectForKey("arrayOfRoles") != nil {
            
            arrayOfRoles = NSUserDefaults.standardUserDefaults().objectForKey("arrayOfRoles") as! [String]
        }
        
        if NSUserDefaults.standardUserDefaults().objectForKey("arrayOfPictures") != nil {
            
            arrayOfPictures = NSUserDefaults.standardUserDefaults().objectForKey("arrayOfPictures") as! [String]
        }
        
        if NSUserDefaults.standardUserDefaults().objectForKey("arrayOfEmails") != nil {
            
            arrayOfEmails = NSUserDefaults.standardUserDefaults().objectForKey("arrayOfEmails") as! [String]
        }
        
        if NSUserDefaults.standardUserDefaults().objectForKey("arrayOfBios") != nil {
            
            arrayOfBios = NSUserDefaults.standardUserDefaults().objectForKey("arrayOfBios") as! [String]
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
        
        return arrayOfNames.count
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->StaffDirectoryTableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! StaffDirectoryTableViewCell

        //cell.staffPicture.image = UIImage(named: "UGM-default-user")
        if InternetConnection.isConnectedToNetwork().boolValue == true{
            cell.staffPicture.image = UIImage(data: NSData(contentsOfURL: NSURL(string: arrayOfPictures[indexPath.row])!)!)
        }
        
        
        cell.staffPicture.layer.shadowOpacity = 0.5
        cell.staffPicture.layer.cornerRadius = cell.staffPicture.frame.size.width / 2
        cell.staffPicture.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        cell.staffPicture.layer.shadowRadius = 15
        cell.staffPicture.layer.shadowColor = UIColor.blackColor().CGColor
        
        cell.staffNameLabel?.text = arrayOfNames[indexPath.row]
        cell.staffEmailLabel?.text = arrayOfRoles[indexPath.row]
        //cell.staffEmailLabel?.text = arrayOfEmails[indexPath.row]
        
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        
        
        rowNumber = indexPath.row
        
        return indexPath
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
