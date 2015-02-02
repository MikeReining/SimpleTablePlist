//
//  Object.swift
//  SimpleTablePlist
//
//  Created by Michael Reining on 2/2/15.
//  Copyright (c) 2015 Mike Reining. All rights reserved.
//

import Foundation

class Object: NSObject, NSCoding {
    var name: String!
    var notes: String?
    init(name: String) {
        self.name = name
    }
    
    // MARK: NSCoding
    
    required init(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObjectForKey("nameKey") as String
        self.notes = aDecoder.decodeObjectForKey("notesKey") as? String
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "nameKey")
        aCoder.encodeObject(notes, forKey: "notesKey")
    }
    
}