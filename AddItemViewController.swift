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
    
}
