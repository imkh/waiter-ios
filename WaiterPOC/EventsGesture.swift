//
//  EventsGesture.swift
//  Waiter
//
//

import Foundation

class EventsGesture : UIViewController {
    
    @IBOutlet var Open: UIBarButtonItem!
    var TableArray = [String]()
    
    override func viewDidLoad() {
        TableArray = ["Cafet"]
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        Open.target = self.revealViewController()
        Open.action = #selector(SWRevealViewController.revealToggle(_:))
    }
    

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(TableArray[indexPath.row], forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = TableArray[indexPath.row]
        
        return cell
    }
}
