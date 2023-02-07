//
//  String+isEmpty.swift
//  RemindersApp
//
//  Created by septe habudin on 02/02/23.
//

import Foundation

extension String { var isEmptyOrWhitespace: Bool { return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty } }
