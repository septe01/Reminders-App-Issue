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
            ReminderCellView(reminder: reminder)
        }
    }
}

//struct ReminderListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReminderListView()
//    }
//}
