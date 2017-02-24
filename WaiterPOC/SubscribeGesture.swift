//
//  SubscribeGesture.swift
//  Waiter
//

import Foundation
import Alamofire
import SwiftyJSON

class SubscribeGesture : UIViewController {

    // MARK: Properties
    
    @IBOutlet weak var firstname: UITextField!
    @IBOutlet weak var lastname: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var repeatedPassword: UITextField!


    // MARK: Action
    
    @IBAction func subscribeCall(sender: UIButton) {
        if (password.text == repeatedPassword.text) {
            subscribe();
        }
    }

    @IBAction func showLogin(sender: UIButton) {
        self.performSegueWithIdentifier("showLoginSegue", sender: self);
    }
    
    func subscribe() {
        let userData = [
            "firstname": firstname.text as! AnyObject,
            "lastname": lastname.text as! AnyObject,
            "email": email.text as! AnyObject,
            "password": password.text as! AnyObject,
            "type": 1
        ];
        Alamofire.request(UserRouter.Subscribe(userData))
            .responseJSON { response in
                guard response.result.error == nil else {
                    print(response.result.error!);
                    print("error calling POST on /user/subscribe/");
                    return ;
                }
                
                if let value: AnyObject = response.result.value {
                    let json = JSON(value);
                    if (json["status"].stringValue == "fail") {
                        print("subscribe failure");
                    } else {
                        self.performSegueWithIdentifier("subscribeSuccessSegue", sender: self);
                        print("subscribe success");
                    }
                }
        }
    }

}
