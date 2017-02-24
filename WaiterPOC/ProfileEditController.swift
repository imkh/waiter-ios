//
//  ProfileEditController.swift
//  Waiter
//
//  Created by quentin huang on 25/01/2017.
//

import Foundation
import Alamofire
import SwiftyJSON
import KeychainAccess

class ProfileEditController : UIViewController {
    
    @IBOutlet weak var Firstname: UITextField!
    
    @IBOutlet weak var Lastname: UITextField!

    @IBOutlet weak var Email: UITextField!
    
    let keychain = Keychain(service: "com.epitech.waiter")
    
    var token: String!;
    
    var userID: String!;
    
    
    override func viewDidAppear(animated: Bool) {
        userInfo();
    }
    
    @IBAction func NewProfile(sender: UIButton) {
        updateUserInfo();
    }
    
    func updateUserInfo() {
        let userData = [
            "firstname": Firstname.text as! AnyObject,
            "lastname": Lastname.text as! AnyObject,
            "email": Email.text as! AnyObject
        ];
        Alamofire.request(UserRouter.UserProfile(keychain["userID"]!, keychain["token"]!, userData)).responseJSON { response in
            guard response.result.error == nil else {
                print(response.result.error!);
                print("error calling GET on /user/:id/");
                return ;
            }
            
            if let value: AnyObject = response.result.value {
                let json = JSON(value);
                if (json["status"].stringValue == "fail") {
                    print("user info failure");
                    print(json);
                } else {
                    self.performSegueWithIdentifier("EndEditSegue", sender: self);
                }
            }
        }
    }
    
    func userInfo() {
        userID = keychain["userID"];
        token = keychain["token"];
        
        Alamofire.request(UserRouter.UserInfo(userID, token))
            .responseJSON { response in
                guard response.result.error == nil else {
                    print(response.result.error!);
                    print("error calling GET on /user/:id/");
                    return ;
                }
                
                if let value: AnyObject = response.result.value {
                    let json = JSON(value);
                    if (json["status"].stringValue == "fail") {
                        print("user info failure");
                        print(json);
                    } else {
                        if let firstname = json["data"]["firstname"].string{
                            self.Firstname.text = firstname;
                        }
                        if let lastname = json["data"]["lastname"].string{
                            self.Lastname.text = lastname;
                        }
                        if let email = json["data"]["email"].string{
                            self.Email.text = email;
                            self.Email.sizeToFit();
                        }
                        print("user info success");
                    }
                }
        }
    }
}
