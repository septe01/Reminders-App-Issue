//
//  RemindersAppApp.swift
//  RemindersApp
//
//  Created by septe habudin on 01/02/23.
//

import SwiftUI

@main
struct RemindersAppApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, CoreDataProvider.shared.persistenContainer.viewContext)
        }
    }
}
