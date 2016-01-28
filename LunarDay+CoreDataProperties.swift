//
//  LunarDay+CoreDataProperties.swift
//  
//
//  Created by Андрей Кропотов on 1/28/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension LunarDay {

    @NSManaged var dayNumber: NSNumber?
    @NSManaged var moonRise: NSNumber?
    @NSManaged var moonSet: NSNumber?

}
