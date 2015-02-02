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
    var object1 = Object(name: "Table Row 1")
    var objectList = [Object]()
    
    @IBAction func addItem(sender: AnyObject) {
        var alert = UIAlertController(title: "New object", message: "Add a table row", preferredStyle: .Alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .Default) { (action: UIAlertAction!) -> Void in
            let textField = alert.textFields![0] as UITextField
            let newObject = Object(name: textField.text)
            self.objectList.append(newObject)
            self.saveWithCoder()
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default) { (action: UIAlertAction!) -> Void in
            
        }
        
        alert.addTextFieldWithConfigurationHandler {
            (textField: UITextField!) -> Void in
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert, animated: true, completion: nil)
        
    }

    
    let dataFilePath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String + "/objectList.plist"
    
    // function to save new item to coder
    func saveWithCoder() -> Bool {
        var data: NSMutableData = NSMutableData.alloc()
        var archiver: NSKeyedArchiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(objectList, forKey: "objectList")
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
            objectList = unArchiver.decodeObjectForKey("objectList") as [Object]
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
        return cell
    }

}

