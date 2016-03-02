//
//  StaffDirectoryDetailsViewController.swift
//  Indata App V2
//
//  Created by IUPUI on 2/22/16.
//  Copyright © 2016 Nicolai Davidsson. All rights reserved.
//

import UIKit

var rowNumber:Int = 0

class StaffDirectoryDetailsViewController: UIViewController {

    @IBOutlet weak var staffPicture: UIImageView!
    
    @IBOutlet weak var staffEmailLabel: UILabel!
    
    @IBOutlet weak var staffRoleLabel: UILabel!
    
    @IBOutlet weak var bioWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var name = [String]()
        
        name = arrayOfNames[rowNumber].componentsSeparatedByString(",")
        
        if name.count > 0 {
            
            self.title = name[0]
        }

        if InternetConnection.isConnectedToNetwork().boolValue == true{
            staffPicture.image = UIImage(data: NSData(contentsOfURL: NSURL(string: arrayOfPictures[rowNumber])!)!)
        }
        

        staffRoleLabel.text = arrayOfRoles[rowNumber]
        staffEmailLabel.text = arrayOfEmails[rowNumber]
        
        
        bioWebView.loadHTMLString(arrayOfBios[rowNumber].stringByReplacingOccurrencesOfString("<a ", withString: "<a style=\" color: black; text-decoration=\"none\" "), baseURL: nil)
        
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
