//
//  Person.swift
//  RealmMigrationTuto
//
//  Created by Tejora on 24/02/20.
//  Copyright © 2020 Tejora. All rights reserved.
//

import UIKit
import RealmSwift

class Person: Object {
    @objc  dynamic var id = 0
    @objc  dynamic var name = ""
    @objc  dynamic var lastName = ""
    @objc  dynamic var email = ""
    @objc  dynamic var lastName1 = ""
    /**
               Override Object.primaryKey() to set the model’s primary key. Declaring a primary key allows objects to be looked up and updated efficiently and enforces uniqueness for each value.
               */
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
