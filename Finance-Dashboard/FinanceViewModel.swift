//
//  FinanceViewModel.swift
//  Finance-Dashboard
//
//  Created by iPHTech 7 on 07/07/26.
//

import Foundation
import SwiftUI

class FinanceViewModel: ObservableObject {
    
    // Published Properties
    
    @Published var transactions: [Transaction] = [
        
        Transaction(
            title: "Monthly Salary",
            amount: 50000,
            category: .salary,
            isIncome: true,
            date: Date()
        ),
        
        Transaction(
            title: "Groceries",
            amount: 2500,
            category: .food,
            isIncome: false,
            date: Date()
        ),
        
        Transaction(
            title: "Movie Night",
            amount: 800,
            category: .entertainment,
            isIncome: false,
            date: Date()
        ),
        
        Transaction(
            title: "Electricity Bill",
            amount: 1500,
            category: .bills,
            isIncome: false,
            date: Date()
        )
    ]
    
    // Computed Properties
    
    var totalIncome: Double {
        transactions
            .filter { $0.isIncome }
            .reduce(0) { $0 + $1.amount }
    }
    
    var totalExpense: Double {
        transactions
            .filter { !$0.isIncome }
            .reduce(0) { $0 + $1.amount }
    }
    
    var totalBalance: Double {
        totalIncome - totalExpense
    }
    
    var savingsGoal: Double {
        100000
    }
    
    var savingsProgress: Double {
        guard savingsGoal > 0 else { return 0 }
        return min(totalBalance / savingsGoal, 1.0)
    }
    
    var currentMonthTransactions: [Transaction] {
        
        let calendar = Calendar.current
        
        return transactions.filter {
            calendar.isDate($0.date,
                            equalTo: Date(),
                            toGranularity: .month)
        }
    }
    
    // Functions
    
    func addTransaction(
        title: String,
        amount: Double,
        category: Category,
        isIncome: Bool
    ) {
        
        let newTransaction = Transaction(
            title: title,
            amount: amount,
            category: category,
            isIncome: isIncome,
            date: Date()
        )
        
        transactions.append(newTransaction)
    }
}
