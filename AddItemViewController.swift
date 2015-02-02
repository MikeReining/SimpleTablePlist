//
//  AddItemViewController.swift
//  SimpleTablePlist
//
//  Created by Michael Reining on 2/2/15.
//  Copyright (c) 2015 Mike Reining. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController {
    let dataFilePath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String + "appData"
    var objectList: [Object]?
    
    @IBOutlet weak var addItemTextField: UITextField!
    @IBOutlet weak var addDescriptionTextField: UITextField!
    
    
    // UI Alert View to update user defaults
    @IBAction func setDefaultsButton(sender: AnyObject) {
        var alert = UIAlertController(title: "Update Default Values", message: "Add default values for new items", preferredStyle: .Alert)
        
        alert.addTextFieldWithConfigurationHandler {
            (textField: UITextField!) -> Void in
            
        }
        
        alert.addTextFieldWithConfigurationHandler {
            (textField1: UITextField!) -> Void in
            
        }

        let textField = alert.textFields![0] as UITextField
        let textField1 = alert.textFields![1] as UITextField
        
        textField.text = self.addItemTextField.text
        textField1.text = self.addDescriptionTextField.text
        
        let saveAction = UIAlertAction(title: "Save", style: .Default) { [unowned self] (action: UIAlertAction!) -> Void in

            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(textField.text, forKey: "itemKey")
            defaults.setObject(textField1.text, forKey: "descriptionKey")
            self.refreshGUI()
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default) { (action: UIAlertAction!) -> Void in
            
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setToolbarHidden(false, animated: true)
        let defaults = NSUserDefaults.standardUserDefaults()
        if let name = defaults.stringForKey("itemKey") {
            addItemTextField.text = name
        }
        if let description = defaults.stringForKey("descriptionKey") {
            addDescriptionTextField.text = description
        }
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        let myObject = Object(name: addItemTextField.text, note: addDescriptionTextField.text)
        objectList?.append(myObject)
        saveWithCoder()
        
    }
    
    
    
    // function to save new item to coder
    func saveWithCoder() -> Bool {
        var data: NSMutableData = NSMutableData.alloc()
        var archiver: NSKeyedArchiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(objectList, forKey: "appData")
        archiver.finishEncoding() 
        data.writeToFile(dataFilePath, atomically: true)
        return true
    }
    
    // Save data whenever user leaves app from add screen
    override func viewDidLoad() {
        let app = UIApplication.sharedApplication()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "saveDataOnNotification:", name: UIApplicationWillResignActiveNotification, object: app)
    }
    
    
    func saveDataOnNotification(notification:NSNotification) {
        let myObject = Object(name: addItemTextField.text, note: addDescriptionTextField.text)
        objectList?.append(myObject)
        saveWithCoder()
    }
    
    
    func refreshGUI() {
        let defaults = NSUserDefaults.standardUserDefaults()
        if let name = defaults.stringForKey("itemKey") {
            addItemTextField.text = name
        }
        if let description = defaults.stringForKey("descriptionKey") {
            addDescriptionTextField.text = description
        }
    }
}
