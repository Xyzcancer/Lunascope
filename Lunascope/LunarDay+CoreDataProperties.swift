//
//  LunarDay+CoreDataProperties.swift
//  
//
//  Created by Андрей Кропотов on 12/30/15.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension LunarDay {

    @NSManaged var dayNumber: NSNumber?
    @NSManaged var moonSet: NSNumber?
    @NSManaged var moonRise: NSNumber?

}
