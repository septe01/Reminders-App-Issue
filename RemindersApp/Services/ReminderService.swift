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

    // service list
    static func saveMyList(_ name: String, _ color: UIColor) throws {
        let myList = MyList(context: viewContext)

        myList.name = name
        myList.color = color

        try save()
    }

    // service reminder
    static func saveReminderToMyList(myList: MyList, reminderTitle: String) throws {
        let reminder = Reminder(context: viewContext)

        reminder.title = reminderTitle
        myList.addToReminders(reminder)

        try save()
    }

    // get reminder by list
    static func getRemindersByList(myList: MyList) -> NSFetchRequest<Reminder> {
        let request = Reminder.fetchRequest()
        request.sortDescriptors = []

        request.predicate = NSPredicate(format: "list = %@ AND isCompleted = false", myList)
        return request
    }

    static func updateReminder(reminder: Reminder, editConfig: ReminderEditConfig) throws -> Bool {
        let reminderToUpdate = reminder
        reminderToUpdate.isCompleted = editConfig.isCompleted
        reminderToUpdate.title = editConfig.title
        reminderToUpdate.notes = editConfig.notes
        reminderToUpdate.reminderDate = editConfig.hasDate ? editConfig.reminderDate : nil
        reminderToUpdate.reminderTime = editConfig.hasTime ? editConfig.reminderTime : nil

        try save()
        return true
    }
}
