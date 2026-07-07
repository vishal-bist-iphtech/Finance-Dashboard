//
//  Transaction.swift
//  Finance-Dashboard
//
//  Created by iPHTech 7 on 07/07/26.
//

import Foundation

struct Transaction: Identifiable {
    
    let id = UUID()
    var title: String    
    var amount: Double
    var category: Category
    var isIncome: Bool
    var date: Date
}
