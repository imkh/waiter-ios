//
//  SettingsGesture.swift
//  Waiter
//
//

import Foundation

class SettingsGesture : UIViewController {
    
    @IBOutlet var Open: UIBarButtonItem!
    
    override func viewDidLoad() {
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        Open.target = self.revealViewController()
        Open.action = #selector(SWRevealViewController.revealToggle(_:))
    }
}
