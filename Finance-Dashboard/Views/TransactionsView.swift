//
//  TransactionView.swift
//  Finance-Dashboard
//
//  Created by iPHTech 7 on 08/07/26.
//

import SwiftUI

struct TransactionsView: View {
    
    @ObservedObject var transactionViewModel: TransactionViewModel
    @State private var searchInput = ""
    
    var filteredTransactions: [Finance_Dashboard.Transaction] {
        if searchInput.isEmpty {
            return Array(transactionViewModel.transactions.reversed())
        }

        return transactionViewModel.transactions
            .filter {
                $0.title.localizedCaseInsensitiveContains(searchInput)
            }
            .reversed()
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()

                ScrollView {
                    LazyVStack(spacing: 12) {
                        if filteredTransactions.isEmpty {
                            VStack(spacing: 12) {
                                Image(systemName: "magnifyingglass")
                                    .font(.largeTitle)
                                    .foregroundColor(.gray)
                                Text("No transactions found")
                                    .foregroundColor(.gray)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 40)
                        } else {
                            ForEach(filteredTransactions) { transaction in
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
                                .padding(.horizontal)
                            }
                        }
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("Transactions")
        }
        .searchable(text: $searchInput, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search transactions..")
    }
}



struct TransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsView(
            transactionViewModel: TransactionViewModel(
                context: PersistenceController.shared.container.viewContext
            )
        )
    }
}
