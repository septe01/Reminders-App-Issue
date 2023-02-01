//
//  ContentView.swift
//  RemindersApp
//
//  Created by septe habudin on 01/02/23.
//

import SwiftUI

struct HomeView: View {

    @State private var isPresented: Bool = false

    var body: some View {
        NavigationStack {
            VStack {
                Text("Hello world")

                Spacer()

                Button{
                    isPresented = true
                } label: {
                    Text("Add List")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .font(.headline)
                }
            }.sheet(isPresented: $isPresented) {
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
        }
        .padding()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environment(\.managedObjectContext, CoreDataProvider.shared.persistenContainer.viewContext)
    }
}
