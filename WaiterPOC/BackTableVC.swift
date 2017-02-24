//
//  BackTableVC.swift
//  Waiter
//
//

import Foundation

class BackTableVC: UITableViewController {
    
    var TableArray = [String]()
    
    override func viewDidLoad() {
        TableArray = ["Profil", "Events", "Settings"]
        
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(TableArray[indexPath.row], forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = TableArray[indexPath.row]
        
        return cell
    }
}
