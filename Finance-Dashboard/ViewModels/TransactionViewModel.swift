//
//  FinanceViewModel.swift
//  Finance-Dashboard
//
//  Created by iPHTech 7 on 07/07/26.
//

import Foundation
import SwiftUI
import CoreData

class TransactionViewModel: ObservableObject {
    
    
    @Published var savingsGoal: Double = 0
    
    private let context: NSManagedObjectContext
    
    @Published var transactions: [Transaction] = []

    init(context: NSManagedObjectContext) {
        self.context = context
        
        loadTransactions()
        loadUserPreferences()
    }
    
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
        max(totalIncome - totalExpense, 0)
    }
    
    var savingsProgress: Double {
        guard savingsGoal > 0 else { return 0 }
        return min(currentMonthSavings / savingsGoal, 1.0)
    }
    
    var currentMonthTransactions: [Transaction] {
        
        let calendar = Calendar.current
        
        return transactions.filter {
            calendar.isDate($0.date,
                            equalTo: Date(),
                            toGranularity: .month)
        }
    }
    
    var currentMonthIncome: Double {
        currentMonthTransactions
            .filter { $0.isIncome }
            .reduce(0) { $0 + $1.amount }
    }
    
    var currentMonthExpense: Double {
        currentMonthTransactions
            .filter { !$0.isIncome }
            .reduce(0) { $0 + $1.amount }
    }
    
    var currentMonthSavings: Double {
        max(currentMonthIncome - currentMonthExpense, 0)
    }
    
    var totalSavings: Double {
        max(totalIncome - totalExpense, 0)
    }
    
    var expenseCategories: [ExpenseCategory] {
        
        var totals: [Category: Double] = [:]
        
        for transaction in transactions where !transaction.isIncome {
            totals[transaction.category, default: 0] += transaction.amount
        }
        
        return totals.map { category, amount in
            
            ExpenseCategory(
                name: category.rawValue,
                value: amount,
                color: color(for: category)
            )
        }
    }
    
    
    
    // MARK: Functions
    
    // MARK: Color mapping function for transaction categories
    private func color(for category: Category) -> Color {
        
        switch category {
            
        case .salary:
            return .green
            
        case .food:
            return .red
            
        case .shopping:
            return .blue
            
        case .travel:
            return .orange
            
        case .bills:
            return .purple
            
        case .entertainment:
            return .pink
            
        case .investment:
            return .yellow
            
        case .other:
            return .gray
        }
    }
    
    
    func addTransaction(
        title: String,
        amount: Double,
        category: Category,
        isIncome: Bool
    ) {
        
        saveToCoreData(
            title: title,
            amount: amount,
            category: category,
            isIncome: isIncome
           )
 
        
// MARK: Manually appending transaction data
//        let newTransaction = Transaction(
//            id: UUID(),
//            title: title,
//            amount: amount,
//            category: category,
//            isIncome: isIncome,
//            date: Date()
//        )
//        
//        transactions.append(newTransaction)
    }
    
    func updateTransaction(
        _ transaction: Transaction,
        title: String,
        amount: Double,
        category: Category,
        isIncome: Bool
    ) {

        guard let entity = fetchEntity(for: transaction) else {
            return
        }

        entity.id = transaction.id
        entity.title = title
        entity.amount = amount
        entity.category = category.rawValue
        entity.isIncome = isIncome
        entity.date = transaction.date

        do {
            try context.save()

            loadTransactions()

        } catch {
            print("Failed to update transaction:", error.localizedDescription)
        }
    }
    
    func deleteTransaction(_ transaction: Transaction) {
        guard let entity = fetchEntity(for: transaction) else { return }
        
        context.delete(entity)
        
        do {
            
            try context.save()
            
            loadTransactions()
            
        } catch {
            print("Failed to delete transaction \n \(error.localizedDescription)")
        }
    }
    
    func loadTransactions() {

        let request: NSFetchRequest<TransactionEntity> =
            TransactionEntity.fetchRequest()

        request.sortDescriptors = [
            NSSortDescriptor(key: "date", ascending: false)
        ]

        do {

            let entities = try context.fetch(request)

            transactions = entities.map { entity in

                Transaction(
                    id: entity.id ?? UUID(),
                    title: entity.title ?? "",
                    amount: entity.amount,
                    category: Category(rawValue: entity.category ?? "other") ?? .other,
                    isIncome: entity.isIncome,
                    date: entity.date ?? Date()
                )

            }

        } catch {

            print("Failed to load transactions:", error.localizedDescription)

        }

    }
    
    private func loadUserPreferences() {
        let request: NSFetchRequest<UserPreferenceEntity> = UserPreferenceEntity.fetchRequest()
        
        do {
            let preferences = try context.fetch(request)
            
            
            if let preference = preferences.first {
                savingsGoal = preference.savings
            } else {
                let preference = UserPreferenceEntity(context: context)
                preference.savings = savingsGoal
                
                try context.save()
            }
            
        } catch {
            print("Failed to load user preferences \n \(error.localizedDescription)")
        }
    }
    
    func updateSavingsGoal(_ amount: Double) {
        let request: NSFetchRequest<UserPreferenceEntity> = UserPreferenceEntity.fetchRequest()
        
        do {
            let preferences = try context.fetch(request)
            
            if let preference = preferences.first {
                preference.savings = amount
            } else {
                let preference = UserPreferenceEntity(context: context)
                preference.savings = amount
            }
            
            try context.save()
            savingsGoal = amount
            
        } catch {
            print("Failed to update user preferences \n \(error.localizedDescription)")
        }
    }
    
    private func saveToCoreData(
        title: String,
        amount: Double,
        category: Category,
        isIncome: Bool
    ) {
        let entity = TransactionEntity(context: context)
        entity.id = UUID()
        entity.title = title
        entity.amount = amount
        entity.category = category.rawValue
        entity.isIncome = isIncome
        entity.date = Date()
        
        do {
            try context.save()
            loadTransactions()
            print("Transaction saved successfully")
        } catch {
            print("Failed to save transaction: ")
            print(error.localizedDescription)
        }
    }
    
    private func fetchEntity(
        for transaction: Transaction
    ) -> TransactionEntity? {

        let request: NSFetchRequest<TransactionEntity> =
            TransactionEntity.fetchRequest()

        request.predicate = NSPredicate(
            format: "id == %@",
            transaction.id as CVarArg
        )

        request.fetchLimit = 1

        do {
            return try context.fetch(request).first
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}


//
//    private func fetchTransactions() {
//
//        let request: NSFetchRequest<TransactionEntity> = TransactionEntity.fetchRequest()
//
//        request.sortDescriptors = [
//            NSSortDescriptor(key: "date", ascending: false)
//        ]
//
//        do {
//            let entities = try context.fetch(request)
//
//            if(entities.isEmpty) {
//                TransactionEntity.CreateDummyData(context: context)
//            } else {
//
//                transactions = entities.map { entity in
//                    Transaction(
//                        id: entity.id ?? UUID(),
//                        title: entity.title ?? "",
//                        amount: entity.amount,
//                        category: Category(rawValue: entity.category ?? "") ?? .other,
//                        isIncome: entity.isIncome,
//                        date: entity.date ?? Date()
//                    )
//                }
//            }
//        } catch {
//            print("Failed to fetch transactions")
//            print(error.localizedDescription)
//        }
//    }

// MARK: Sample transactions
//        Transaction(
//            id: UUID(),
//            title: "Monthly Salary",
//            amount: 50000,
//            category: .salary,
//            isIncome: true,
//            date: Date()
//        ),
//
//        Transaction(
//            id: UUID(),
//            title: "Groceries",
//            amount: 2500,
//            category: .food,
//            isIncome: false,
//            date: Date()
//        ),
//
//        Transaction(
//            id: UUID(),
//            title: "Movie Night",
//            amount: 800,
//            category: .entertainment,
//            isIncome: false,
//            date: Date()
//        ),
//        Transaction(
//            id: UUID(),
//            title: "EMI",
//            amount: 2200,
//            category: .bills,
//            isIncome: false,
//            date: Date()
//        ),
//
//        Transaction(
//            id: UUID(),
//            title: "Electricity Bill",
//            amount: 1500,
//            category: .bills,
//            isIncome: false,
//            date: Date()
//        ),
//        Transaction(
//            id: UUID(),
//            title: "Groceries",
//            amount: 500,
//            category: .shopping,
//            isIncome: false,
//            date: Date()
//        ),
//        Transaction(
//            id: UUID(),
//            title: "Pizza",
//            amount: 400,
//            category: .food,
//            isIncome: false,
//            date: Date()
//        ),
//        Transaction(
//            id: UUID(),
//            title: "SIP",
//            amount: 1000,
//            category: .investment,
//            isIncome: false,
//            date: Date()
//        ),
//        Transaction(
//            id: UUID(),
//            title: "Borrowed",
//            amount: 1500,
//            category: .investment,
//            isIncome: true,
//            date: Date()
//        ),
//        Transaction(
//            id: UUID(),
//            title: "Phone Recharge",
//            amount: 500,
//            category: .bills,
//            isIncome: false,
//            date: Date()
//        ),
//        Transaction(
//            id: UUID(),
//            title: "Taxi fare",
//            amount: 800,
//            category: .travel,
//            isIncome: false,
//            date: Date()
//        ),
//        Transaction(
//            id: UUID(),
//            title: "Ice-cream",
//            amount: 200,
//            category: .food,
//            isIncome: false,
//            date: Date()
//        ),
    
