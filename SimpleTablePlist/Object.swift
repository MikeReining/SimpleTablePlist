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
    var note: String?
    init(name: String, note: String?) {
        self.name = name
        self.note = note
    }
    
    // MARK: NSCoding
    
    required init(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObjectForKey("nameKey") as String
        self.note = aDecoder.decodeObjectForKey("notesKey") as? String
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "nameKey")
        aCoder.encodeObject(note, forKey: "notesKey")
    }
    
}