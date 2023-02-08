//
//  CustomOperators.swift
//  RemindersApp
//
//  Created by septe habudin on 08/02/23.
//

import Foundation
import SwiftUI

public func ?? <T> (lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
    Binding(
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue = $0 }
    )

}


