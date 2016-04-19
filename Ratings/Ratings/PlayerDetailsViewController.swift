//
//  PlayerDetailsViewController.swift
//  Ratings
//
//  Created by HyunWindows on 2016. 4. 14..
//  Copyright © 2016년 HyunWindows. All rights reserved.
//

import UIKit

class PlayerDetailsViewController: UITableViewController {
    
    var player:Player?

    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        if segue.identifier == "SavePlayerDetail"{
            player = Player(name: nameTextField.text!, game: "Chess", rating:1)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        if indexPath.section == 0{
            nameTextField.becomeFirstResponder()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

        
}
