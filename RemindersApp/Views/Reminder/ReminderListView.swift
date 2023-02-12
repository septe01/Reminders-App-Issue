//
//  ReminderListView.swift
//  RemindersApp
//
//  Created by septe habudin on 07/02/23.
//

import SwiftUI

struct ReminderListView: View {

    let reminders: FetchedResults<Reminder>
    @State private var selectedReminder: Reminder?
    @State private var showReminderDetail: Bool = false
    
    private func  reminderCheckedChanged(reminder: Reminder, isCompleted: Bool) {
        var editConfig = ReminderEditConfig(reminder: reminder)
//        editConfig.isCompleted = !reminder.isCompleted
        editConfig.isCompleted = isCompleted

        do {
           let _ = try ReminderService.updateReminder(reminder: reminder, editConfig: editConfig)
        } catch {
            print(error)
        }

    }

    private func isReminderSelected(_ reminder: Reminder) -> Bool {
        selectedReminder?.objectID == reminder.objectID
    }

    private func deleteReminder(_ indexSet: IndexSet) {
        indexSet.forEach { index in
            let reminder = reminders[index]
            do {
                try ReminderService.deleteReminder(reminder)
            }catch {
                print(error)
            }
        }
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(reminders) { reminder in
                    ReminderCellView(reminder: reminder, isSelected: isReminderSelected(reminder)) { event in
                        switch event {
                        case .onSelect(let reminder):
        //                    print("ON SELECTED \(reminder)")
                            selectedReminder = reminder
                        case .onCheckedChange(let reminder, let isCompleted):
                            reminderCheckedChanged(reminder: reminder, isCompleted: isCompleted)
                        case .onInfo:
                            showReminderDetail = true
                        }

                    }
                }.onDelete { IndexSet in
                    deleteReminder(IndexSet)
                }
            }
        }.sheet(isPresented: $showReminderDetail) {
            ReminderDetailView(reminder: Binding($selectedReminder)!)
        }
    }
}

struct ReminderListView_Previews: PreviewProvider {

    // create properti wrapper cara ini error ga bisa
//    @FetchRequest(sortDescriptors: [])
//    private var reminderResults: FetchedResults<Reminder>

    // cara menggunakan container
    struct ReminderListViewContainer: View {

        @FetchRequest(sortDescriptors: [])
        private var reminderResults: FetchedResults<Reminder>

        var body: some View {
            ReminderListView(reminders: reminderResults)
        }
    }


    static var previews: some View {
        ReminderListViewContainer()
            .environment(\.managedObjectContext, CoreDataProvider.shared.persistenContainer.viewContext)

//        ReminderListView(reminders: reminderResults)
    }
}
