//
//  ReminderDetailListView.swift
//  RemindersApp
//
//  Created by septe habudin on 08/02/23.
//

import SwiftUI

struct ReminderDetailListView: View {

    @FetchRequest(sortDescriptors: [])
    private var myListFetchResult: FetchedResults<MyList>

    @Binding var selectedList: MyList?

    var body: some View {
        List(myListFetchResult) { myList in
            HStack {
                HStack {
                    Image(systemName: "line.3.horizontal.circle.fill")
                        .foregroundColor(Color(myList.color))
                    Text(myList.name)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentShape(Rectangle())
                .onTapGesture {
                    self.selectedList = myList
                }

                Spacer()
                
                if selectedList == myList {
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}

struct ReminderDetailListView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderDetailListView(selectedList: .constant(PreviewData.myList))
            .environment(\.managedObjectContext, CoreDataProvider.shared.persistenContainer.viewContext)
    }
}
