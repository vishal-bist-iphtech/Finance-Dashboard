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
        NavigationView {
            ZStack {
                VStack {
                    // MARK: Header
                    HStack {
                        Text("Finance Dashboard")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding()
                        
                        Spacer()
                        
                        Button(action: {
                            showingAddTransaction = true
                        }) {
                            Image(systemName: "plus")
                                .font(.title)
                                .padding()
                                .cornerRadius(20)
                                .frame(width: 40, height: 40)
                                .foregroundColor(.black)
                        }
                        .padding(.horizontal)
                        .sheet(isPresented: $showingAddTransaction) {
                            AddTransactionView(
                                transactionViewModel: transactionViewModel
                            )
                        }
                    }
                    
                    ScrollView {
                        VStack(spacing: 20) {
                            // MARK: Balance
                            SummaryCard(
                                title: "Total Balance",
                                amount: transactionViewModel.totalBalance,
                                color: .blue
                            )
                            
                            // MARK: Income & Expense
                            HStack(spacing: 15) {
                                SummaryCard(
                                    title: "Income",
                                    amount: transactionViewModel.totalIncome,
                                    color: .green
                                )
                                
                                SummaryCard(
                                    title: "Expense",
                                    amount: transactionViewModel.totalExpense,
                                    color: .red
                                )
                            }
                            Divider()
                            
                            // MARK: Monthly Summary
                            
                            MonthlySummary(transactionViewModel: transactionViewModel)
                            Divider()
                            
                            
                            // MARK: Chart
                            HStack{
                                Text("Expense Insights")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                            }
                            
                           DonutChart(
                            data: transactionViewModel.expenseCategories
                           )
                            
                            // legends for donut chart
                            VStack(alignment: .leading, spacing: 12) {

                                ForEach(transactionViewModel.expenseCategories) { item in

                                            HStack {

                                                Circle()
                                                    .fill(item.color)
                                                    .frame(width: 12, height: 12)

                                                Text(item.name)
                                                    .font(.subheadline)

                                                Spacer()

                                                Text("₹\(item.value, specifier: "%.0f")")
                                                    .font(.subheadline)
                                                    .foregroundColor(.secondary)

                                            }

                                        }

                                    }
                                    .padding(.horizontal)
                            
                            Divider()
                            
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
                        }
                        .padding()
                    }
                    .scrollIndicators(.hidden)
                }
                
            }
            .navigationBarHidden(true)
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(
            transactionViewModel: TransactionViewModel(
                context: PersistenceController.shared.container.viewContext
            )
        )
    }
}
