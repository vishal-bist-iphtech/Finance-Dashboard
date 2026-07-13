//
//  Extensions.swift
//  Finance-Dashboard
//
//  Created by iPHTech 34 on 13/07/26.
//

import Foundation
import CoreData

extension TransactionEntity {
    static func CreateDummyData (context: NSManagedObjectContext) {
        let dummyData: [(String, Double, String, Bool)] = [
            ("Monthly Salary", 50000, "Salary", true),
            ("Groceries", 2500, "Food", false),
            ("Movie Night", 800, "Entertainment", true),
            ("EMI", 2200, "Bills", false),
            ("Electricity Bill", 1500, "Bills", false),
            ("Staionary", 500, "Shopping", false),
            ("Pizza", 400, "Food", false),
            ("SIP", 1000, "Investment", false),
            ("Borrowed", 1500, "Others", true),
            ("Wifi", 900, "Bills", false),
            ("Taxi Fare", 800, "Travel", false),
            ("Ice-cream", 200, "Food", false),
        ]
        
        for data in dummyData {
            let transaction = TransactionEntity(context: context)
            
            transaction.id = UUID()
            transaction.title = data.0
            transaction.amount = data.1
            transaction.category = data.2
            transaction.isIncome = data.3
            transaction.date = Date()
        }
        
        do {
            try context.save()
            print("Dummy data saved")
        } catch {
            print("Error while saving dummy data: \n \(error.localizedDescription)")
        }
    }
    
}
