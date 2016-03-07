//
//  LogoutViewController.swift
//  InstagramParse
//
//  Created by Kevin Duong on 3/6/16.
//  Copyright © 2016 Kevin Duong. All rights reserved.
//

import UIKit
import Parse

class LogoutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    static let userDidLogoutNotification = "userDidLogout"
    
    @IBAction func onLogout(sender: AnyObject) {
        PFUser.logOutInBackgroundWithBlock { (error: NSError?) -> Void in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                print("logout true")
                NSNotificationCenter.defaultCenter().postNotificationName(LogoutViewController.userDidLogoutNotification, object: nil)
            }
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
