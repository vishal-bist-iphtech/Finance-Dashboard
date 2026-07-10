//
//  TransactionRow.swift
//  Finance-Dashboard
//
//  Created by iPHTech 7 on 07/07/26.
//

import SwiftUI

struct TransactionRow: View {
    
    let transaction: Transaction
    
    var body: some View {
        
        HStack {
            
            VStack(alignment: .leading, spacing: 5) {
                
                Text(transaction.title)
                    .font(.headline)
                
                Text(transaction.category.rawValue)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 5) {
                
                Text(transaction.isIncome ? "+₹\(transaction.amount, specifier: "%.2f")"
                                          : "-₹\(transaction.amount, specifier: "%.2f")")
                    .foregroundColor(transaction.isIncome ? .green : .black)
                    .fontWeight(.bold)
                
                Text(dateFormatter.string(from: transaction.date))
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 5)
    }
}

private let dateFormatter: DateFormatter = {
    
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    
    return formatter
}()

struct TransactionRow_Previews: PreviewProvider {
    
    static var previews: some View {
        
        TransactionRow(
            transaction: Transaction(
                id: UUID(),
                title: "Salary",
                amount: 50000,
                category: .salary,
                isIncome: true,
                date: Date()
            )
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
