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

    @State private var search: String = ""
    @State private var searching: Bool = false
    @State private var isPresented: Bool = false


    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {

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
