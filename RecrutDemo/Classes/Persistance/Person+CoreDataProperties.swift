//
//  Person+CoreDataProperties.swift
//  RecrutDemo
//
//  Created by Przemyslaw Probola on 15/11/2016.
//  Copyright © 2016 YouGov. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person");
    }

    @NSManaged public var name: String?

}
