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
                                .sheet(isPresented: $showingAddTransaction) {
                                    AddTransactionView(
                                        transactionViewModel: transactionViewModel
                                    )
                                }
                            
                            // MARK: Monthly Summary
                            MonthlySummary(transactionViewModel: transactionViewModel)
                            
                            // MARK: Recent transactions
                            RecentTransactions(transactionViewModel: transactionViewModel)
                        }
                    }
                    .scrollIndicators(.hidden)
                }                
            }
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
