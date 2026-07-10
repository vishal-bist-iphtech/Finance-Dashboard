//
//  ExpenseCategory.swift
//  Finance-Dashboard
//
//  Created by iPHTech 7 on 09/07/26.
//

import SwiftUI

struct ExpenseCategory: Identifiable {
    let id = UUID()
    let name: String
    let value: Double
    let color: Color
}
