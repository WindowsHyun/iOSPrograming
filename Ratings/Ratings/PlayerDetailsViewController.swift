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
    
    var game:String = "Chess"{
        didSet{
            detailLabel.text? = game
        }
    }
    
    var rating:String = "1"{
        didSet{
            detaiRatinglLabel.text? = rating
        }
    }
    

    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var detaiRatinglLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBAction func unwindWithSelectedGame(segue:UIStoryboardSegue) {
        if let gamePickerViewController = segue.sourceViewController as? GamePickerViewController,
            selectedGame = gamePickerViewController.selectedGame {
            game = selectedGame
        }
        if let RatingPickerViewController = segue.sourceViewController as? RatingPickerViewController,
            selectedRating = RatingPickerViewController.selectedRating {
            rating = selectedRating
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        if segue.identifier == "SavePlayerDetail"{
            player = Player(name: nameTextField.text!, game: game, rating:Int(rating)!)
        }
        
        if segue.identifier == "PickGame"{
            if let GamePickerViewController = segue.destinationViewController as? GamePickerViewController{
                GamePickerViewController.selectedGame = game
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder){
        print("init PlayerDetaillsViewController")
        super.init(coder: aDecoder)
    }
    
    deinit{
        print("deinit PlayerDetailsViewController")
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
