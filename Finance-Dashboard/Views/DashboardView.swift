//
//  DashboardView.swift
//  Finance-Dashboard
//
//  Created by iPHTech 7 on 07/07/26.
//

import SwiftUI

struct DashboardView: View {
    
    @ObservedObject var transactionViewModel: TransactionViewModel
    
    // toogle to whether show the addTransaction sheet or not
    @State private var showingAddTransaction = false
    
    @Environment(\.managedObjectContext)
    
    private var viewContext
    
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                VStack {
                    ScrollView {
                        VStack(spacing: 20) {
                            
                            // MARK: Header
                            
                            HeaderCard(showingAddTransaction: $showingAddTransaction, transactionViewModel: transactionViewModel)
                            
                            // MARK: Monthly Summary
                            
                            MonthlySummary(transactionViewModel: transactionViewModel)
                            
                            // MARK: Recent transactions
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Recent Transactions")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                
                                ForEach(transactionViewModel.transactions.reversed().prefix(5)) { transaction in
                                    VStack(spacing: 0) {
                                        TransactionRow(transaction: transaction)
                                            .padding(12)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(
                                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                                            .fill(Color(.secondarySystemBackground))
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                                            .stroke(Color.black.opacity(0.05), lineWidth: 0.5)
                                    )
                                    .shadow(color: Color.black.opacity(0.06), radius: 6, x: 0, y: 3)
                                }
                            }
                            .padding()
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
                    
                    .scrollIndicators(.hidden)
                }
                
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
        DashboardView(
            transactionViewModel: TransactionViewModel(
                context: PersistenceController.shared.container.viewContext
            )
        )
}
