//
//  ContentView.swift
//  RemindersApp
//
//  Created by septe habudin on 01/02/23.
//

import SwiftUI

struct HomeView: View {

    // fetch properti wraper
    @FetchRequest(sortDescriptors: [])
    private var myListResults: FetchedResults<MyList>

    //fetchrequest
    @FetchRequest(sortDescriptors: [])
    private var searchResults: FetchedResults<Reminder>

    // fetch by type
    @FetchRequest(fetchRequest: ReminderService.remidersByStatType(statType: .today))
    private var todayResults: FetchedResults<Reminder>

    @FetchRequest(fetchRequest: ReminderService.remidersByStatType(statType: .scheduled))
    private var scheduledResults: FetchedResults<Reminder>

    @FetchRequest(fetchRequest: ReminderService.remidersByStatType(statType: .all))
    private var allResults: FetchedResults<Reminder>

    @FetchRequest(fetchRequest: ReminderService.remidersByStatType(statType: .complted))
    private var completedResults: FetchedResults<Reminder>


    @State private var search: String = ""
    @State private var searching: Bool = false
    @State private var isPresented: Bool = false

    private var remiderStatsBuilder = ReminderStateBuilder()
    @State private var reminderStatsValues = ReminderStateValues()

    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {

                    HStack {
                        NavigationLink {
                            ReminderListView(reminders: todayResults)
                        } label: {
                            ReminderStatsView(icon: "calendar", title: "Today", count: reminderStatsValues.todayCount)
                        }

                        NavigationLink {
                            ReminderListView(reminders: scheduledResults)
                        } label: {
                            ReminderStatsView(icon: "tray.circle.fill", title: "Schaduled", count: reminderStatsValues.schaduleCount, iconColor: .red)
                        }


                    }

                    HStack {
                        NavigationLink {
                            ReminderListView(reminders: allResults)
                        } label: {
                            ReminderStatsView(icon: "calendar.circle.fill", title: "All", count: reminderStatsValues.allCount, iconColor: .secondary)
                        }

                        NavigationLink {
                            ReminderListView(reminders: completedResults)
                        } label: {
                            ReminderStatsView(icon: "checkmark.circle.fill", title: "Completed", count: reminderStatsValues.completedCount, iconColor: .primary)
                        }


                    }


                    Text("My List")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.largeTitle)
                        .bold()
                        .padding()

                    MyListView(myLists: myListResults)

    //                Spacer()

                    Button{
                        isPresented = true
                    } label: {
                        Text("Add List")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .font(.headline)
                    }
                    
                }

            }
            .onChange(of: search, perform: { searchTerm in
               searching = !searchTerm.isEmpty ? true : false

                // call search service
                searchResults.nsPredicate = ReminderService.getRemindersBySearch(search: search).predicate
            })
            .overlay(content: {
                ReminderListView(reminders: searchResults)
                    .opacity(searching ? 1.0 : 0.0)
            })
            .onAppear {
                reminderStatsValues = remiderStatsBuilder.build(myListResults: myListResults)
            }
            .sheet(isPresented: $isPresented) {
                NavigationStack {
                    AddNewListView(onSave: { (name, color) in
                        // save list to database
                        do {
                            try ReminderService.saveMyList(name, color)
                        } catch {
                            print(error)
                        }

                    })
                }
            }
            .padding()
            .navigationTitle("Reminders")

        }
        .searchable(text: $search)

    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environment(\.managedObjectContext, CoreDataProvider.shared.persistenContainer.viewContext)
    }
}
