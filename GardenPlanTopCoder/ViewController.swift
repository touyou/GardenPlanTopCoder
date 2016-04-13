//
//  ViewController.swift
//  GardenPlanTopCoder
//
//  Created by 藤井陽介 on 2016/04/09.
//  Copyright © 2016年 touyou. All rights reserved.
//

import UIKit

protocol ViewControllerDelegate {
    func updateGarden(garden: [Bed])
}

class ViewController: UITableViewController, ViewControllerDelegate {
    var gardenBeds = [Bed]()
    var selectedBed: Int!
    
    let saveData: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.registerNib(UINib(nibName: "BedsTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        if let data = saveData.objectForKey("garden") as? NSData {
            gardenBeds = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! [Bed]
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toFlowerView" {
            let flowerView: FlowerViewController = segue.destinationViewController as! FlowerViewController
            flowerView.selected = selectedBed
            flowerView.garden = gardenBeds
            flowerView.delegate = self
        }
    }
    
    // MARK: - TableView

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gardenBeds.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: BedsTableViewCell = tableView.dequeueReusableCellWithIdentifier("cell") as! BedsTableViewCell
        let bed = gardenBeds[indexPath.row]
        let flowers = bed.getFlowers()
        cell.nameLabel.text = bed.name
        cell.reset()
        for i in 0 ..< bed.getSize() {
            switch i {
            case 0:
                cell.flowerView1.backgroundColor = flowers[i].color
                cell.flowerLabel1.text = (flowers[i].name as NSString).substringToIndex(1).uppercaseString
            case 1:
                cell.flowerView2.backgroundColor = flowers[i].color
                cell.flowerLabel2.text = (flowers[i].name as NSString).substringToIndex(1).uppercaseString
            case 2:
                cell.flowerView3.backgroundColor = flowers[i].color
                cell.flowerLabel3.text = (flowers[i].name as NSString).substringToIndex(1).uppercaseString
            case 3:
                cell.flowerView4.backgroundColor = flowers[i].color
                cell.flowerLabel4.text = (flowers[i].name as NSString).substringToIndex(1).uppercaseString
            case 4:
                cell.flowerView5.backgroundColor = flowers[i].color
                cell.flowerLabel5.text = (flowers[i].name as NSString).substringToIndex(1).uppercaseString
            default: break
            }
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedBed = indexPath.row
        performSegueWithIdentifier("toFlowerView", sender: nil)
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        gardenBeds.removeAtIndex(indexPath.row)
        let saveBed = NSKeyedArchiver.archivedDataWithRootObject(self.gardenBeds)
        saveData.setObject(saveBed, forKey: "garden")
        tableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: indexPath.row, inSection: 0)],
                                         withRowAnimation: UITableViewRowAnimation.Fade)
    }
    
    // MARK: - Button
    
    @IBAction func plusButton() {
        let alert = UIAlertController(title: "Add Bed", message: "Type New Bed's Name", preferredStyle: .Alert)
        let cancelButton = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        let addButton = UIAlertAction(title: "Add", style: .Default, handler: { action in
            let textFields = alert.textFields! as Array<UITextField>?
            if textFields != nil {
                for textField in textFields! {
                    let bed = Bed()
                    bed.name = textField.text
                    self.gardenBeds.append(bed)
                    let saveBed = NSKeyedArchiver.archivedDataWithRootObject(self.gardenBeds)
                    self.saveData.setObject(saveBed, forKey: "garden")
                    self.tableView.reloadData()
                }
            }
        })
        alert.addAction(cancelButton)
        alert.addAction(addButton)
        alert.addTextFieldWithConfigurationHandler({ text in
            text.placeholder = "Type Name"
        })
        presentViewController(alert, animated: true, completion: nil)
    }
    
    // MARK: - Delegate
    
    func updateGarden(garden: [Bed]) {
        self.gardenBeds = garden
        self.tableView.reloadData()
    }
}

