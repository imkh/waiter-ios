//
//  LoginGesture.swift
//  Waiter
//
//

import Foundation
import Alamofire
import SwiftyJSON
import KeychainAccess

class LoginGesture : UIViewController {
    
    @IBOutlet weak var Email: UITextField!
    
    @IBOutlet weak var Password: UITextField!
    
    let keychain = Keychain(service: "com.epitech.waiter")
    
    override func viewDidLoad() {

    }
    
    @IBAction func callLoginUrl(sender: UIButton) {
        login();
    }
    
    func login() {
        let authData = [
            "email": Email.text as! AnyObject,
            "password": Password.text as! AnyObject
        ];
        Alamofire.request(UserRouter.Login(authData))
            .responseJSON { response in
                guard response.result.error == nil else {
                    print(response.result.error!);
                    print("error calling POST on /user/login/");
                    return ;
                }
                
                if let value: AnyObject = response.result.value {
                    let json = JSON(value);

                    if (json["status"].stringValue == "fail") {
                        print("login failure");
                    } else {
                        self.performSegueWithIdentifier("mainPageSegue", sender: self);
                        if let token = json["data"]["token"].string{
                            self.keychain["token"] = token;                            
                            print("login success");
                            print(token);
                        }
                        if let userID = json["data"]["user"]["_id"].string{
                            self.keychain["userID"] = userID;
                            print(userID);
                        }
                    }
                }
        }
    }
}
