//
//  CoreDataProvider.swift
//  RemindersApp
//
//  Created by septe habudin on 01/02/23.
//

import Foundation
import CoreData

class CoreDataProvider {
    
    static let shared = CoreDataProvider()
    let persistenContainer: NSPersistentContainer


    private init() {
        persistenContainer = NSPersistentContainer(name: "RemindersModel")

        persistenContainer.loadPersistentStores { description, error in
            if let error {
                fatalError("Error initializing ReminderModel \(error)")
            }
        }
    }
}
