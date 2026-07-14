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
    @State private var selectedTransaction: Transaction?
    @State private var deleteTransaction: Transaction?
    @State private var confirmDeletion = false
    
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
                List {

                    if filteredTransactions.isEmpty {

                        VStack(spacing: 12) {

                            Image(systemName: "magnifyingglass")
                                .font(.largeTitle)
                                .foregroundStyle(.gray)

                            Text("No transactions found")
                                .foregroundStyle(.gray)

                        }
                        .frame(maxWidth: .infinity)
                        .listRowBackground(Color.clear)

                    } else {

                        ForEach(filteredTransactions) { transaction in

                            TransactionCard(transaction: transaction)
                                .listRowInsets(EdgeInsets())
                                .listRowSeparator(.hidden)
                                .listRowBackground(Color.clear)
                                .padding(.vertical, 6)
                                .onTapGesture {
                                    selectedTransaction = transaction
                                }
                                .swipeActions(edge: .trailing) {

                                    Button(role: .destructive) {

                                        deleteTransaction = transaction
                                        
                                        confirmDeletion = true

                                    } label: {

                                        Label("Delete", systemImage: "trash")

                                    }

                                }
                                .padding(.horizontal,6)

                        }

                    }

                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .background(Color(.systemGroupedBackground))
            }
            .sheet(item: $selectedTransaction) { transaction in
                EditTransactionView(
                    transactionViewModel: transactionViewModel,
                    transaction: transaction
                )
            }
            .navigationTitle("Transactions")
        }
        .searchable(text: $searchInput, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search transactions..")
        .alert("Delete Transaction?", isPresented: $confirmDeletion) {

            Button("Cancel", role: .cancel) {
                deleteTransaction = nil
            }

            Button("Delete", role: .destructive) {

                if let transaction = deleteTransaction {
                    transactionViewModel.deleteTransaction(transaction)
                }
                
                deleteTransaction = nil

            }

        } message: {

            Text("This action cannot be undone.")

        }
    }
}



#Preview {
    TransactionsView(
        transactionViewModel: TransactionViewModel(
            context: PersistenceController.shared.container.viewContext
        )
    )
}
