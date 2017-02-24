//
//  NewPasswordController.swift
//  Waiter
//
//  Created by quentin huang on 25/01/2017.
//

import Foundation
import Alamofire
import SwiftyJSON
import KeychainAccess

class NewPasswordController : UIViewController {
    
    @IBOutlet weak var Password: UITextField!
    
    @IBOutlet weak var NewPassword: UITextField!
    
    @IBOutlet weak var ConfirmPassword: UITextField!

    let keychain = Keychain(service: "com.epitech.waiter")
    
    var token: String!;
    
    var userID: String!;
    
    @IBAction func NewPassword(sender: UIButton) {
        if (NewPassword.text == ConfirmPassword.text) {
            updateUserPassword();
        }
    }
    
    func updateUserPassword() {
        let userData = [
            "password": Password.text as! AnyObject,
            "newPassword": NewPassword.text as! AnyObject
        ];
        Alamofire.request(UserRouter.UserPassword(keychain["userID"]!, keychain["token"]!, userData)).responseJSON { response in
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
                    self.performSegueWithIdentifier("EndNewPasswordSegue", sender: self);
                }
            }
        }
    }
}
