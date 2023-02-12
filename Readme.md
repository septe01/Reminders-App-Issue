# Reminders App Clone 


Reminders App Clone with SwiftUI & Core Data With [Mohammad Azam](https://www.udemy.com/course/building-a-reminders-app-clone-with-swiftui-core-data/)


## Ralation CoreData
- one list have many remainder


### Notification
- in the main app add di config

import UserNotifications

@main
struct RemindersAppApp: App {

    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                // notification is granted
            } else {
                // display message to the user
            }
        }
    }
}

