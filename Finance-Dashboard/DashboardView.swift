//
//  DashboardView.swift
//  Finance-Dashboard
//
//  Created by iPHTech 7 on 07/07/26.
//

import SwiftUI

struct DashboardView: View {

    @StateObject private var viewModel = FinanceViewModel()

    @State private var showingAddTransaction = false

    var body: some View {

        NavigationView {

            ScrollView {

                VStack(spacing: 20) {

                    // Balance Card

                    SummaryCard(
                        title: "Total Balance",
                        amount: viewModel.totalBalance,
                        color: .blue
                    )

                    // Income & Expense

                    HStack(spacing: 15) {

                        SummaryCard(
                            title: "Income",
                            amount: viewModel.totalIncome,
                            color: .green
                        )

                        SummaryCard(
                            title: "Expense",
                            amount: viewModel.totalExpense,
                            color: .red
                        )

                    }

                    // Monthly Summary

                    VStack(alignment: .leading, spacing: 10) {

                        Text("Monthly Summary")
                            .font(.headline)

                        Text("Transactions This Month: \(viewModel.currentMonthTransactions.count)")

                        Text("Savings Goal")

                        ProgressView(value: viewModel.savingsProgress)

                        Text("\(Int(viewModel.savingsProgress * 100))% Completed")
                            .font(.caption)
                            .foregroundColor(.gray)

                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(15)

                    // MARK: Chart

                    BarChartView(
                        transactions: viewModel.transactions
                    )

                    // Transactions

                    VStack(alignment: .leading, spacing: 10) {

                        Text("Recent Transactions")
                            .font(.headline)

                        ForEach(viewModel.transactions.reversed()) { transaction in

                            TransactionRow(
                                transaction: transaction
                            )

                            Divider()

                        }

                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(15)

                }
                .padding()

            }
            .navigationBarTitle("Finance Dashboard")

            .navigationBarItems(trailing:

                Button(action: {

                    showingAddTransaction = true

                }) {

                    Image(systemName: "plus")

                }

            )

            .sheet(isPresented: $showingAddTransaction) {

                AddTransactionView(
                    viewModel: viewModel
                )

            }

        }

    }

}

struct DashboardView_Previews: PreviewProvider {

    static var previews: some View {

        DashboardView()

    }

}
