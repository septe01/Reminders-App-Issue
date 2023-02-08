//
//  ReminderListView.swift
//  RemindersApp
//
//  Created by septe habudin on 07/02/23.
//

import SwiftUI

struct ReminderListView: View {

    let reminders: FetchedResults<Reminder>

    var body: some View {
        List(reminders) { reminder in
            ReminderCellView(reminder: reminder) { event in
                switch event {
                case .onSelect(let reminder):
                    print("ON SELECTED")
                case .onCheckedChange(let reminder):
                    print("On Checked Change")
                case .onInfo:
                    print("on Info.")
                }

            }
        }
    }
}

//struct ReminderListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReminderListView()
//    }
//}
