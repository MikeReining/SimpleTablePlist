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
    init(name: String) {
        self.name = name
    }
    
    required init(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObjectForKey("nameKey") as String
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        super.encode()
        aCoder.encodeObject(name, forKey: "nameKey")
    }
    
}