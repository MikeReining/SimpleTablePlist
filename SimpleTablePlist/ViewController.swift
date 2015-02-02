//
//  ViewController.swift
//  SimpleTablePlist
//
//  Created by Michael Reining on 2/2/15.
//  Copyright (c) 2015 Mike Reining. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var todo1 = Object(name: "Task 1")
    var todoList = [Object]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoList.append(todo1)
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
        return todoList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell") as UITableViewCell
        let task = todoList[indexPath.row]
        cell.textLabel?.text = task.name
        return cell
    }

}

