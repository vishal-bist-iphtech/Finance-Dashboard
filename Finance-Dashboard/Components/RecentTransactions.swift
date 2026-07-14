//
//  RecentTransactions.swift
//  Finance-Dashboard
//
//  Created by iPHTech 34 on 13/07/26.
//

import SwiftUI

struct RecentTransactions: View {
    
    @ObservedObject var transactionViewModel: TransactionViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Recent Transactions")
                .font(.title2)
                .fontWeight(.semibold)
            
            ForEach(transactionViewModel.transactions.reversed().prefix(5)) { transaction in
                VStack(spacing: 0) {
                    TransactionCard(transaction: transaction)
                        
                }
            }
        }
        .padding(.horizontal, 6)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color(.systemBackground))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(Color.black.opacity(0.05), lineWidth: 0.5)
        )
        .shadow(
            color: Color.black.opacity(0.06),
            radius: 6,
            x: 0,
            y: 3)
    }
}

#Preview {
    RecentTransactions(transactionViewModel: TransactionViewModel(
        context: PersistenceController.shared.container.viewContext
    ))
}
