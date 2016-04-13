//
//  FlowerViewController.swift
//  GardenPlanTopCoder
//
//  Created by 藤井陽介 on 2016/04/10.
//  Copyright © 2016年 藤井陽介. All rights reserved.
//

import UIKit

class FlowerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SwiftColorPickerDelegate, UIPopoverPresentationControllerDelegate {
    @IBOutlet var flowerTableView: UITableView!
    var garden: [Bed]!
    var selected: Int!
    var selectedFlower: NSIndexPath?
    var delegate: ViewControllerDelegate!
    
    let saveData: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "\(garden[selected].name)'s Flowers"
        flowerTableView.registerNib(UINib(nibName: "FlowerTableViewCell",bundle: nil), forCellReuseIdentifier: "flowerCell")
        flowerTableView.delegate = self
        flowerTableView.dataSource = self
    }

    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        delegate.updateGarden(garden)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toColorPicker" {
            let colorPicker = segue.destinationViewController as! SwiftColorPickerViewController
            colorPicker.delegate = self
        }
    }
    
    // MARK: - TableView
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return garden[selected].getSize()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: FlowerTableViewCell = tableView.dequeueReusableCellWithIdentifier("flowerCell") as! FlowerTableViewCell
        let flower = garden[selected].getFlowers()
        cell.colorView.backgroundColor = flower[indexPath.row].color
        cell.nameLabel.text = flower[indexPath.row].name
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedFlower = indexPath
        performSegueWithIdentifier("toColorPicker", sender: nil)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        garden[selected].flowers.removeAtIndex(indexPath.row)
        let saveBed = NSKeyedArchiver.archivedDataWithRootObject(self.garden)
        saveData.setObject(saveBed, forKey: "garden")
        tableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: indexPath.row, inSection: 0)],
                                         withRowAnimation: UITableViewRowAnimation.Fade)
    }
    
    // MARK: - PopOverDelegate
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
    
    // MARK: - ColorPickerDelegate
    
    func colorSelectionChanged(selectedColor color: UIColor) {
        garden[selected].flowers[selectedFlower!.row].color = color
        selectedFlower = nil
        let saveBed = NSKeyedArchiver.archivedDataWithRootObject(self.garden)
        saveData.setObject(saveBed, forKey: "garden")
        flowerTableView.reloadData()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Button
    
    @IBAction func plusButton() {
        if garden[selected].getSize() >= 5 {
            let alert = UIAlertController(title: "Error", message: "You've already added five flowers in this bed.", preferredStyle: .Alert)
            let cancelButton = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
            alert.addAction(cancelButton)
            presentViewController(alert, animated: true, completion: nil)
            return
        }
        let alert = UIAlertController(title: "Add Flower", message: "Type New Flower's Name(Default Color is Red. Please Tap and Set Color.)", preferredStyle: .Alert)
        let cancelButton = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        let addButton = UIAlertAction(title: "Add", style: .Default, handler: { action in
            let textFields = alert.textFields! as Array<UITextField>?
            if textFields != nil {
                for textField in textFields! {
                    let flower = Flower(name: textField.text!, color: UIColor.redColor())
                    let _ = self.garden[self.selected].setFlower(flower)
                    let saveBed = NSKeyedArchiver.archivedDataWithRootObject(self.garden)
                    self.saveData.setObject(saveBed, forKey: "garden")
                    self.flowerTableView.reloadData()
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
}
