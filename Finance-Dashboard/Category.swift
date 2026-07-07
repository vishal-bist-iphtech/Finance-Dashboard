//
//  Category.swift
//  Finance-Dashboard
//
//  Created by iPHTech 7 on 07/07/26.
//

import Foundation

enum Category: String, CaseIterable, Identifiable {
    
    case salary = "Salary"
    case food = "Food"
    case shopping = "Shopping"
    case travel = "Travel"
    case bills = "Bills"
    case entertainment = "Entertainment"
    case investment = "Investment"
    case other = "Other"
    
    var id: String {
        rawValue
    }
}
