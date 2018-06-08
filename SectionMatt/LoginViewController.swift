//
//  LoginViewController.swift
//  SectionMatt
//
//  Created by Rohan Nagesh on 7/29/17.
//  Copyright © 2017 Rohan Nagesh. All rights reserved.
//

import UIKit
import Parse
import ParseFacebookUtilsV4


class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func fbButtonPressed() {
        let requestedFBPermissions = ["public_profile"]
        
        PFFacebookUtils.logInInBackground(withReadPermissions: requestedFBPermissions) { (user, error) in
            if let user = user {
                if user.isNew {
                    print("User signed up and logged in through Facebook!")
                    //Perform Graph requests to fetch FB user info
                    let requestParams = ["fields": "id, first_name, last_name"]
                    let fbGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: requestParams)
                    
                    fbGraphRequest?.start(completionHandler: { (connection, result, error) in
                        if error != nil {
                            print("Error fetching user info from Facebook")
                        } else if result != nil {
                            let result = result as! NSDictionary
                            user["fb_id"] = result["id"]!
                            user["first_name"] = result["first_name"]!
                            user["last_name"] = result["last_name"]!
                            
                            //Store user details to Parse cloud
                            user.saveInBackground(block: { (success, error) in
                                if error != nil {
                                    print("Error saving user info to Parse")
                                } else {
                                    print("Successfully saved user info to Parse")
                                    self.performSegue(withIdentifier: "loginToStart", sender: self)
                                }
                            })
                        }
                    })
                } else {
                    print("User already exists and logged in through Facebook!")
                    self.performSegue(withIdentifier: "loginToStart", sender: self)
                }
            } else {
                print("Uh oh. The user cancelled the Facebook login.")
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
