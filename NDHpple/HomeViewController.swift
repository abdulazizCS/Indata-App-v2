//
//  HomeViewController.swift
//  NDHpple
//
//  Created by IUPUI on 2/19/16.
//  Copyright © 2016 Nicolai Davidsson. All rights reserved.
//

import UIKit

var query:String = ""

class HomeViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBarNew: UISearchBar!
    

    
    let searchController = UISearchController(searchResultsController: nil)

    
    @IBAction func loadResults(sender: AnyObject) {

        query = searchBarNew.text!

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        

        if InternetConnection.isConnectedToNetwork().boolValue == true {
            print("Internet is working!")
        } else {
            print("There is no internet connection")
            let alert = UIAlertView(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }
        
        var buttonToChange : UIButton
        
        for var i = 1; i < 7; i++ {
            
            buttonToChange = view.viewWithTag(i) as! UIButton
            
            buttonToChange.layer.cornerRadius = 5
            buttonToChange.layer.shadowColor = UIColor.blackColor().CGColor
            buttonToChange.layer.shadowOpacity = 0.3
            buttonToChange.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            buttonToChange.layer.shadowRadius = 3
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

    }
//    func searchBarSearchButtonClicked( searchBar: UISearchBar) {
//        
//        let vc = self.storyboard!.instantiateViewControllerWithIdentifier("searchResults") as! SearchResultsViewController
//        self.presentViewController(vc, animated: true, completion: nil)
//    
//
//    }
    
    override func viewDidAppear(animated: Bool) {

        //sarrayOfTitles = [String]()

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
