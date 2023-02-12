//
//  MyList+CoreDataClasss.swift
//  RemindersApp
//
//  Created by septe habudin on 01/02/23.
//

import Foundation
import CoreData

@objc(MyList)
public class MyList: NSManagedObject {

    var remindersArray: [Reminder] {
        reminders?.allObjects.compactMap {($0 as! Reminder) } ?? []
    }
}
