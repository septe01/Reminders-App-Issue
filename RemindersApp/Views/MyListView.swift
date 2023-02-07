//
//  MyListView.swift
//  RemindersApp
//
//  Created by septe habudin on 02/02/23.
//

import SwiftUI

struct MyListView: View {

    let myLists: FetchedResults<MyList>

    var body: some View {
        NavigationStack {
            if myLists.isEmpty {
                Spacer()
                Text("No reminder found")
            } else {
                ForEach(myLists) { myList in
                    VStack {
                        NavigationLink(value: myList) {
                            VStack {
                                MyListCellView(myList: myList)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding([.leading], 10)
                                    .font(.title3)
                                Divider()
                            }
                        }

                    }
                }
                .scrollContentBackground(.hidden)
                .navigationDestination(for: MyList.self) { myList in
                    MyListDetailView(myList: myList)
                        .navigationTitle(myList.name)
                }
            }
        }
    }
}

//struct MyListView_Previews: PreviewProvider {
//    static var previews: some View {
//        MyListView()
//    }
//}
