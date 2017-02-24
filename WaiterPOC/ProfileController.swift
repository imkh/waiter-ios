//
//  ProfilGesture.swift
//  Waiter
//
//

import Foundation
import Alamofire
import SwiftyJSON
import KeychainAccess

class ProfileController : UIViewController {

    @IBOutlet weak var Firstname: UILabel!

    @IBOutlet weak var Lastname: UILabel!
    
    @IBOutlet weak var Email: UILabel!

    let keychain = Keychain(service: "com.epitech.waiter")
    
    var token: String!;
    
    var userID: String!;
    
    override func viewDidAppear(animated: Bool) {
        userInfo();
    }

    @IBAction func EditProfile(sender: UIButton) {
        self.performSegueWithIdentifier("EditProfileSegue", sender: self);
    }
    
    
    @IBAction func NewPassword(sender: UIButton) {
        self.performSegueWithIdentifier("NewPasswordSegue", sender: self);
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
                            self.Firstname.sizeToFit();
                        }
                        if let lastname = json["data"]["lastname"].string{
                            self.Lastname.text = lastname;
                            self.Lastname.sizeToFit();
                        }
                        if let email = json["data"]["email"].string{
                            self.Email.text = email;
                            self.Email.sizeToFit();
                            self.Email.center.x = self.view.center.x;
                        }
                        print("user info success");
                    }
                }
        }
    }
}
