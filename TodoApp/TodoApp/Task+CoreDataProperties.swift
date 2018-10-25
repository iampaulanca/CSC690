//
//  Task+CoreDataProperties.swift
//  TodoApp
//
//  Created by Paul Ancajima on 10/24/18.
//  Copyright © 2018 Paul Ancajima. All rights reserved.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var name: String?
    @NSManaged public var checked: Bool

}
