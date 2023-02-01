//
//  ReminderService.swift
//  RemindersApp
//
//  Created by septe habudin on 01/02/23.
//

import Foundation
import CoreData
import UIKit

class ReminderService {

    static var viewContext: NSManagedObjectContext {
        CoreDataProvider.shared.persistenContainer.viewContext
    }

    static func save() throws {
        try viewContext.save()
    }

    static func saveMyList(_ name: String, _ color: UIColor) throws {
        let myList = MyList(context: viewContext)

        myList.name = name
        myList.color = color

        try save()
    }
}