//
//  MyListDetailView.swift
//  RemindersApp
//
//  Created by septe habudin on 04/02/23.
//

import SwiftUI

struct MyListDetailView: View {

    let myList: MyList
    @State private var openAddReminder: Bool = false
    @State private var title: String = ""

    @FetchRequest(sortDescriptors: [])
    private var reminderResults: FetchedResults<Reminder>

    private var isFormValid: Bool {
        !title.isEmpty
    }

    // fetch reminder
    init(myList: MyList) {
        self.myList = myList
//        _reminderResults = FetchRequest(fetchRequest: Reminder.fetchRequest())
        _reminderResults = FetchRequest(fetchRequest: ReminderService.getRemindersByList(myList: myList))

    }


    var body: some View {
        VStack {

            // Display list of reminder
            ReminderListView(reminders: reminderResults)

            HStack {
                Image(systemName: "plus.circle.fill")
                Button("New Reminder") {
                    openAddReminder = true
                }
            }.foregroundColor(.blue)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
        }.alert("New Reminder", isPresented: $openAddReminder) {
            TextField("", text: $title)
            Button("Cancel", role: .cancel) {}
            Button("Done") {
                if isFormValid {
                    // save reminder to list
                    print(title)
                    do {
                        try ReminderService.saveReminderToMyList(myList: myList, reminderTitle: title)
                    } catch  {
                        print(error)
                    }
                }
            }
        }
    }
}

struct MyListDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MyListDetailView(myList: PreviewData.myList)
    }
}
