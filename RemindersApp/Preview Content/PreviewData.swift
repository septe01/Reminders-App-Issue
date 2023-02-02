//
//  PreviewData.swift
//  RemindersApp
//
//  Created by septe habudin on 02/02/23.
//

import Foundation

class PreviewData {

    static var myList: MyList {
        let viewContext = CoreDataProvider.shared.persistenContainer.viewContext

//        fetch local data 
        let request = MyList.fetchRequest()

        return (try? viewContext.fetch(request).first) ?? MyList()
    }
}
