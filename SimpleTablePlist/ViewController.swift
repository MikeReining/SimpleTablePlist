//
//  ViewController.swift
//  SimpleTablePlist
//
//  Created by Michael Reining on 2/2/15.
//  Copyright (c) 2015 Mike Reining. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var object1 = Object(name: "Table Row 1", note: "my detailed notes go here")
    var objectList = [Object]()
    
    @IBAction func addItem(sender: AnyObject) {
        var alert = UIAlertController(title: "New object", message: "Add a table row", preferredStyle: .Alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .Default) { (action: UIAlertAction!) -> Void in
            let textField1 = alert.textFields![0] as UITextField
            textField1.placeholder = "Add title"
            let textField2 = alert.textFields![1] as UITextField
            textField2.placeholder = "Add notes"
            let newObject = Object(name: textField1.text,note: textField2.text)
            self.objectList.append(newObject)
            self.saveWithCoder()
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default) { (action: UIAlertAction!) -> Void in
            
        }
        
        alert.addTextFieldWithConfigurationHandler {
            (textField: UITextField!) -> Void in
        }
        
        alert.addTextFieldWithConfigurationHandler {
            (textField: UITextField!) -> Void in
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert, animated: true, completion: nil)
        
    }

    
    let dataFilePath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String + "appData"
    
    // function to save new item to coder
    func saveWithCoder() -> Bool {
        var data: NSMutableData = NSMutableData.alloc()
        var archiver: NSKeyedArchiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(objectList, forKey: "appData")
        archiver.finishEncoding()
        data.writeToFile(dataFilePath, atomically: true)
        return true
    }
    
    // function to store list in coder
    func loadWithCoder() {
        let filePath = self.dataFilePath
        if NSFileManager.defaultManager().fileExistsAtPath(filePath) {
            var data: NSData = NSData(contentsOfFile: filePath)!
            var unArchiver: NSKeyedUnarchiver = NSKeyedUnarchiver(forReadingWithData: data)
            objectList = unArchiver.decodeObjectForKey("appData") as [Object]
            unArchiver.finishDecoding()
        } else {
            println("No data archive exists, creating empty Checklist")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        objectList.append(object1)
        loadWithCoder()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell") as UITableViewCell
        let object = objectList[indexPath.row]
        cell.textLabel?.text = object.name
        cell.detailTextLabel?.text = object.note
        return cell
    }
    
    // Swipe to Delete Row in Table View
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            let deleteObject = objectList[indexPath.row]
            objectList.removeAtIndex(indexPath.row) // update data model BEFORE updating / removing table view row
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        }
    }
    

}

