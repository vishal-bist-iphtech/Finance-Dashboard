//
//  TransactionRow.swift
//  Finance-Dashboard
//
//  Created by iPHTech 34 on 07/07/26.
//


import SwiftUI
struct TransactionCard: View {
    let transaction: Transaction
    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 5) {
                Text(transaction.title) .font(.headline)
                Text(transaction.category.rawValue)
                .font(.caption)
                .foregroundColor(Color(.systemBackground))
            }
            Spacer()
            VStack( spacing: 5) {
                Text(transaction.isIncome ? "+₹\(transaction.amount, specifier: "%.2f")" : "-₹\(transaction.amount, specifier: "%.2f")")
                .foregroundColor(transaction.isIncome ? .green : .primary)
                .fontWeight(.bold)
                Text(dateFormatter.string(from: transaction.date))
                .font(.caption2)
                .foregroundColor(.gray)
                
            }
            .padding(.vertical, 5)
            
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(Color(.systemBackground))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .stroke(.secondary.opacity(0.05), lineWidth: 0.5)
        )
        .shadow(color: .secondary.opacity(0.2), radius: 6, x: 0, y: 3)
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
}()

#Preview {

    TransactionCard(
        transaction: Transaction(
            id: UUID(),
            title: "Salary",
            amount: 50000,
            category: .salary,
            isIncome: true,
            date: Date()
        )
    )
    .padding()

}
