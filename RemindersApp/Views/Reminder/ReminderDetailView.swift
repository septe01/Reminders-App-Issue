//
//  ReminderDetailView.swift
//  RemindersApp
//
//  Created by septe habudin on 08/02/23.
//

import SwiftUI

struct ReminderDetailView: View {

    @Environment(\.dismiss) private var dismiss
    @Binding var reminder: Reminder
    @State var editConfig: ReminderEditConfig = ReminderEditConfig()

    private var isFormValid: Bool {
        !editConfig.title.isEmpty
    }

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section {
                        TextField("Title", text: $editConfig.title)
                        // $editConfig.notes ?? "" akan memuncul kan error buat custom operator
                        TextField("Notes", text: $editConfig.notes ?? "")
                    }

                    Section {
                        Toggle(isOn: $editConfig.hasDate, label: {
                            Image(systemName: "calendar")
                                .foregroundColor(.red)
                        })

                        if editConfig.hasDate {
                            DatePicker("Select Date", selection: $editConfig.reminderDate ?? Date(), displayedComponents: .date)
                        }

                        Toggle(isOn: $editConfig.hasTime, label: {
                            Image(systemName: "clock")
                                .foregroundColor(.red)
                        })

                        if editConfig.hasTime {
                            DatePicker("Select Time", selection: $editConfig.reminderTime ?? Date(), displayedComponents: .hourAndMinute)
                        }

                        Section {
                            NavigationLink {
                                ReminderDetailListView(selectedList: $reminder.list)
                            } label: {
                                HStack {
                                    Text("List")
                                    Spacer()
                                    Text(reminder.list!.name)
                                }
                            }
                        }
                    }
                    .onChange(of: editConfig.hasDate) { hasDate in
                        if hasDate {
                            editConfig.reminderDate = Date() //set current date
                        }
                    }.onChange(of: editConfig.hasTime) { hasTime in
                        if hasTime {
                            editConfig.reminderTime = Date()
                        }
                    }
                }
//                .listStyle(.sidebar)
            }
            .onAppear {
                editConfig = ReminderEditConfig(reminder: reminder)
            }
            .toolbar(content: {
                ToolbarItem(placement: .principal) {
                    Text("Detail")
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {

                            do {
                                let _ = try  ReminderService.updateReminder(reminder: reminder, editConfig: editConfig)
                            } catch  {
                                print(error)
                            }
                        dismiss()
                        //make sure form is valid
                    }.disabled(!isFormValid)
                }


                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancle") {
                        dismiss()
                    }
                }

            })
        }
    }
}

struct ReminderDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderDetailView(reminder: .constant(PreviewData.reminder))
    }
}
