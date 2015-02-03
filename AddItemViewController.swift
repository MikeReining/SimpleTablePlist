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
    
    // load draft in viewWillAppear if draft is present
    override func viewWillAppear(animated: Bool) {
        loadDraft()
    }
    
    // function to save new item to NSCoder
    func saveWithCoder() -> Bool {
        let myObject = Object(name: addItemTextField.text, note: addDescriptionTextField.text)
        objectList?.append(myObject)
        var data: NSMutableData = NSMutableData.alloc()
        var archiver: NSKeyedArchiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(objectList, forKey: "appData")
        archiver.finishEncoding() 
        data.writeToFile(dataFilePath, atomically: true)
        return true
    }
    
    override func viewDidLoad() {
        // Setup NSNotification so that we can immediately save draft if app will become inactive
        let app = UIApplication.sharedApplication()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "saveDraftOnNotification:", name: UIApplicationWillResignActiveNotification, object: app)
        addDescriptionTextField.contentVerticalAlignment = .Top
    }
    
    // function being called anytime NSNotifiation gets fired to save draft
    func saveDraftOnNotification(notification:NSNotification) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(addItemTextField.text, forKey: "itemKey")
        defaults.setObject(addDescriptionTextField.text, forKey: "descriptionKey")
    
    }
    
    // when view appears load the draft data if a draft is present
    func loadDraft() {
        let defaults = NSUserDefaults.standardUserDefaults()
        if let name = defaults.stringForKey("itemKey") {
            addItemTextField.text = name
        }
        if let description = defaults.stringForKey("descriptionKey") {
            addDescriptionTextField.text = description
        }
    }
    
    // if the user goes back to main view delete draft since data is saved
    func deleteDraft() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject("", forKey: "itemKey")
        defaults.setObject("", forKey: "descriptionKey")
    }
    
}

// MARK: Navigation controller extension
// when ViewController becomes top view controller again, save data with coder and delete draft
// This function gets called when back button is pressed

extension AddItemViewController:UINavigationControllerDelegate {
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        //if top VC is main VC, then do something
        if navigationController.topViewController.isMemberOfClass(ViewController) {
            saveWithCoder()
            deleteDraft()
        }
        
    }
}
