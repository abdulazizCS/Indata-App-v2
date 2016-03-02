//
//  AboutViewController.swift
//  NDHpple
//
//  Created by IUPUI on 2/20/16.
//  Copyright © 2016 Nicolai Davidsson. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController, UITableViewDelegate {

    
    var categories = ["Our Story","Staff Directory", "Contact Us"]
    
    override func viewDidLoad() {
        super.viewDidLoad()


        
    
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories.count
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> AboutTableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! AboutTableViewCell
        
        
        cell.AboutCatLabel?.text = categories[indexPath.row]
        
        
        return cell
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
