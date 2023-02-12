//
//  ReminderStateBuilder.swift
//  RemindersApp
//
//  Created by septe habudin on 12/02/23.
//

import Foundation
import SwiftUI

struct ReminderStateValues {
    var todayCount: Int = 0
    var schaduleCount: Int = 0
    var allCount: Int = 0
    var completedCount: Int = 0
}

struct ReminderStateBuilder {

    func build(myListResults: FetchedResults<MyList>) -> ReminderStateValues {
        let remindersArray = myListResults.map {
                                $0.remindersArray
        }.reduce([], +)

        let todaysCount = calculateTodaysCount(reminders: remindersArray)
        let schaduledCount = calculateSchaduledCount(reminders: remindersArray)
        let completedCount = calculateCompletedCount(reminders: remindersArray)
        let allCount = calculateAllCount(reminders: remindersArray)

        return ReminderStateValues(todayCount: todaysCount, schaduleCount: schaduledCount, allCount: allCount, completedCount: completedCount)
    }

    private func calculateSchaduledCount(reminders: [Reminder]) -> Int {
        return reminders.reduce(0) {result, reminder in
            return ((reminder.reminderDate != nil || reminder.reminderTime != nil ) &&  !reminder.isCompleted ) ? result + 1 : result
        }
    }

    private func calculateTodaysCount(reminders: [Reminder]) -> Int {
        return reminders.reduce(0) {result, reminder in
            let isToday = reminder.reminderDate?.isToday ?? false

            return isToday ? result + 1 : result
        }
    }

    private func calculateCompletedCount(reminders: [Reminder]) -> Int {
        return reminders.reduce(0) {result, reminder in
            return reminder.isCompleted ? result + 1 : result
        }
    }

    private func calculateAllCount(reminders: [Reminder]) -> Int {
        return reminders.reduce(0) {result, reminder in
            return !reminder.isCompleted ? result + 1 : result
        }
    }

}
