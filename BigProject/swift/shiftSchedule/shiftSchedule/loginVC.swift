//
//  loginVC.swift
//  shiftSchedule
//
//  Created by Chris Su on 2016-03-21.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import UIKit
import SwiftyJSON
import AFDateHelper

class loginVC: UIViewController {
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var passWord: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.cornerRadius = 5
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor.whiteColor().CGColor
        
        userName.attributedPlaceholder = NSAttributedString(string: "User Name", attributes: [NSForegroundColorAttributeName : UIColor.whiteColor()])
        userName.backgroundColor = UIColor(red: 129/255, green: 191/255, blue: 69/255, alpha: 1.0)
        passWord.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSForegroundColorAttributeName : UIColor.whiteColor()])
        passWord.backgroundColor = UIColor(red: 129/255, green: 191/255, blue: 69/255, alpha: 1.0)
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if NSUserDefaults.standardUserDefaults().valueForKey(userId) != nil {
            self.performSegueWithIdentifier("login", sender: nil)
        }
    }
    
    @IBAction func LoginButtonPressed(sender: UIButton) {
        if let userLoginName = userName.text where userLoginName != "", let loginPassword = passWord.text
            where loginPassword != "" {
            
            let LoginApi = LoginModel(textUserName:userLoginName, textPassword:loginPassword)
            loader.startAnimating()
            
            LoginApi.getLogin { (responseObject, error) in
                
                if error == nil {
                    if let tempResponseObject = responseObject {
                        let response = JSON(tempResponseObject)
                        if(response["status"] != "Success") {
                            self.showErrorAlert("Error", msg: "Wrong username or password")
                        } else {
                            var userableIdArray = [String]()
                            var companyIdArray = [String]()
                            var companyNameArray = [String]()
                            var companyStartArray = [String]()
                            for(_,subJson) in response["data"] {
                                if let userableId = subJson["userableId"].int, companyID =  subJson["companyId"].int, companyName = subJson["company"].string, companyStartDate = subJson["companyStartDate"].string {
                                    userableIdArray.append(String(userableId))
                                    companyIdArray.append(String(companyID))
                                    companyNameArray.append(companyName)
                                    companyStartArray.append(companyStartDate)
                                }
                            }
                            
                            let firstName = response["userFirstName"].string!
                            let lastName = response["userLastName"].string!
                            
                            let id = response["data"][0]["userableId"].int!
                            let companyId = response["data"][0]["companyId"].int!
                            let deviceUserId = response["data"][0]["userId"].int!
                            
                            let companyStartDate = response["data"][0]["companyStartDate"].string!
                            let startDateNsDate = NSDate(fromString:  companyStartDate, format: .ISO8601(nil))

                            NSUserDefaults.standardUserDefaults().setValue(startDateNsDate, forKey: dateSession)
                            
                            NSUserDefaults.standardUserDefaults().setValue(firstName, forKey: userFirstName)
                            
                            NSUserDefaults.standardUserDefaults().setValue(lastName, forKey: userLastName)
                            
                            NSUserDefaults.standardUserDefaults().setValue(deviceUserId, forKey: mydeviceUserId)
                            NSUserDefaults.standardUserDefaults().setValue(id, forKey: userId)
                            NSUserDefaults.standardUserDefaults().setValue(companyId, forKey: company_Id)
                            NSUserDefaults.standardUserDefaults().setObject(userableIdArray, forKey: myUserIdArray)
                            NSUserDefaults.standardUserDefaults().setObject(companyIdArray, forKey: myCompanyIdArray)
                            NSUserDefaults.standardUserDefaults().setObject(companyNameArray, forKey: myCompanyNameArray)
                            NSUserDefaults.standardUserDefaults().setObject(companyStartArray, forKey: companyStartDateArray)
                            NSUserDefaults.standardUserDefaults().synchronize()
                            self.performSegueWithIdentifier("login", sender: nil)
                        }
                        self.loader.stopAnimating()
                    }
                } else {
                    self.showErrorAlert("Error", msg: "problem with your network")
                    self.loader.stopAnimating()
                }
            }
            
        } else {
            showErrorAlert("Email and Password Require", msg: "you must enter an email and a password")
        }
    }
    
    func showErrorAlert(title:String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion:nil)
    }
}

extension loginVC {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(loginVC.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
