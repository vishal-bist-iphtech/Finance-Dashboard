//
//  InsightsView.swift
//  Finance-Dashboard
//
//  Created by iPHTech 34 on 13/07/26.
//

import SwiftUI

struct InsightsView: View {
    
    @ObservedObject var transactionViewModel: TransactionViewModel
    @State private var selectedTimeFrame: TimeFrame = .monthly
    
    enum TimeFrame: String, CaseIterable {
        case weekly = "Weekly"
        case monthly = "Monthly"
        case yearly = "Yearly"
    }
    
    private var totalExpense: Double {
        transactionViewModel.expenseCategories.reduce(0) { $0 + $1.value }
    }
    
    private var highestCategory: ExpenseCategory? {
        transactionViewModel.expenseCategories.max(by: {
            $0.value < $1.value
        })
    }
    
    private var averageExpense: Double {
        let expenses = transactionViewModel.transactions.filter {
            !$0.isIncome
        }
        guard !expenses.isEmpty else {
            return 0
        }
        return expenses.reduce(0) { $0 + $1.amount } / Double(expenses.count)
    }
    
    private var totalIncome: Double {
        transactionViewModel.transactions.filter { $0.isIncome }
            .reduce(0) { $0 + $1.amount }
    }
    
    private var savingsRate: Double {
        guard totalIncome > 0 else { return 0 }
        return max((totalIncome - totalExpense) / totalIncome * 100 ,0)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // MARK: - Header
                    VStack (alignment: .leading) {
                        Text("Insights")
                            .font(.largeTitle)
                            .bold()
                        Text("Understand your spending")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                    }
                    
                    
                    // MARK: - Time Frame Selector
//                    HStack(spacing: 0) {
//                        ForEach(TimeFrame.allCases, id: \.self) { frame in
//                            Button {
//                                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
//                                    selectedTimeFrame = frame
//                                }
//                            } label: {
//                                Text(frame.rawValue)
//                                    .font(.subheadline.weight(.medium))
//                                    .frame(maxWidth: .infinity)
//                                    .padding(.vertical, 8)
//                                    .background(
//                                        selectedTimeFrame == frame ?
//                                        Color.blue : Color.clear
//                                    )
//                                    .foregroundStyle(
//                                        selectedTimeFrame == frame ?
//                                            .white : .secondary
//                                    )
//                                    .clipShape(Capsule())
//                            }
//                        }
//                    }
//                    .padding(4)
//                    .background(Color(.systemGray6))
//                    .clipShape(Capsule())
                    
                    // MARK: - Summary Cards
                    HStack(spacing: 12) {
                        SummaryCard(
                            title: "Total Spent",
                            amount: totalExpense,
                            icon: "creditcard.fill",
                            color: .red
                        )
                        
                        SummaryCard(
                            title: "Total Income",
                            amount: totalIncome,
                            icon: "arrow.down.circle.fill",
                            color: .green
                        )
                        
                        SummaryCard(
                            title: "Total Savings",
                            amount: transactionViewModel.currentMonthSavings,
                            icon: "percent",
                            color: .blue
                        )
                    }
                    
                    // MARK: - Chart Section
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("Expense Breakdown")
                                .font(.title3)
                                .bold()
                            
                        }
                        .padding(.bottom)
                        
                        DonutChart(data: transactionViewModel.expenseCategories)
                                .frame(height: 220)
                        
                        // legends
                        VStack(alignment: .leading, spacing: 16) {
                                ForEach(transactionViewModel.expenseCategories) { item in
                                    CategoryRow(category: item,
                                        total: totalExpense
                                    )
                                }
                            }
                    }
                    .padding(16)
                    .background(.background)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(color: Color.black.opacity(0.05), radius: 8, y: 4)
                    
                    
                    // MARK: - Insights Summary
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Insights Summary")
                            .font(.headline)
                        
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 12) {
                            InsightCard(
                                title: "Highest Category",
                                value: highestCategory?.name ?? "-",
                                icon: "chart.pie.fill",
                                color: .blue
                            )
                            
                            InsightCard(
                                title: "Avg. Expense",
                                value: "₹\(String(format: "%.1f", averageExpense))",
                                icon: "creditcard.fill",
                                color: .red
                            )
                            
                            InsightCard(
                                title: "Savings Rate",
                                value: "₹\(String(format: "%.1f", savingsRate))",
                                icon: "percent",
                                color: .green
                            )
                            
                            InsightCard(
                                title: "Transactions",
                                value: "\(transactionViewModel.transactions.count)",
                                icon: "list.bullet",
                                color: .black
                            )
                        }
                    }
                    .padding()
                    .background(.background)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(color: Color.black.opacity(0.05), radius: 8, y: 4)
                }
                .padding()
                }
                .scrollIndicators(.hidden)
            }
            .background(Color(.systemGroupedBackground))
            .navigationBarHidden(true)
        }
}

#Preview {
    InsightsView(transactionViewModel: TransactionViewModel(
        context: PersistenceController.shared.container.viewContext
    ))
}
