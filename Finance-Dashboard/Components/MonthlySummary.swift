//
//  MonthlySummary.swift
//  Finance-Dashboard
//
//  Created by iPHTech 7 on 09/07/26.
//

import SwiftUI

struct MonthlySummary: View {
    
    @ObservedObject var transactionViewModel: TransactionViewModel
    @State private var showAddSavingsGoal = false
    
    private let currentMonth: String = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"  // Full month name (January, February...)
        return formatter.string(from: Date())
    }()
    
    private let currentYear: String = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter.string(from: Date())
    }()
    
    
    var body: some View {
        VStack(spacing: 4) {
            // Header Section
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Monthly Summary")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("\(currentMonth) \(currentYear)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                }
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 16)
            .padding(.bottom, 12)
            
            Divider()
                .padding(.horizontal,20)
            
            // Stats Section
            VStack(spacing: 16) {
                // Total Transactions
                HStack {
                    Image(systemName: "arrow.triangle.swap")
                        .font(.caption)
                    Text("Total Transactions")
                        .font(.subheadline)
                    Spacer()
                    Text("\(transactionViewModel.currentMonthTransactions.count)")
                        .font(.headline)
                        .fontWeight(.semibold)
                }
                
                // Income & Expense Row
                HStack(spacing: 16) {
                    // Income Card
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Image(systemName: "arrow.down.circle.fill")
                                .foregroundColor(.green)
                            Text("Income")
                                .font(.caption)
                                .foregroundColor(.black)
                        }
                        Text("₹\(transactionViewModel.currentMonthIncome, specifier: "%.2f")")
                            .font(.title3)
                            .fontWeight(.bold)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(12)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                    
                    // Expense Card
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Image(systemName: "arrow.up.circle.fill")
                                .foregroundColor(.red)
                            Text("Expense")
                                .font(.caption)
                        }
                        Text("₹\(transactionViewModel.currentMonthExpense, specifier: "%.2f")")
                            .font(.title3)
                            .fontWeight(.bold)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(12)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                }
            }
            .padding(.horizontal,20)
            .padding(.vertical, 12)
            
            Divider()
                .padding(.horizontal)
            
            // Savings Section
            VStack(spacing: 12) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Savings Goal")
                            .font(.subheadline)
                            .fontWeight(.medium)
                        Text("₹\(transactionViewModel.currentMonthSavings, specifier: "%.2f") of ₹\(transactionViewModel.savingsGoal, specifier: "%.2f") saved")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    Button(action: { showAddSavingsGoal = true }) {
                        Label("Add", systemImage: "plus.circle.fill")
                            .font(.subheadline)
                            .foregroundColor(.black)
                    }
                    .sheet(isPresented: $showAddSavingsGoal) {
                        AddSavingsGoalView(
                            transactionViewModel: transactionViewModel
                        )
                    }
                }
                
                // Progress Bar
                VStack(alignment: .leading, spacing: 6) {
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            // Background track
                            Rectangle()
                                .fill(Color.gray.opacity(0.2))
                                .frame(height: 8)
                                .cornerRadius(4)
                            
                            // Progress fill
                            Rectangle()
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(colors: [.red, .green]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .frame(width: geometry.size.width * CGFloat(transactionViewModel.savingsProgress), height: 8)
                                .cornerRadius(4)
                                .animation(.spring(), value: transactionViewModel.savingsProgress)
                        }
                    }
                    .frame(height: 8)
                    
                    HStack {
                        Text("\(Int(transactionViewModel.savingsProgress * 100))%")
                            .font(.caption)
                            .fontWeight(.semibold)
                        Text("Completed")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Spacer()
                        if transactionViewModel.savingsProgress >= 1.0 {
                            Image(systemName: "star.fill")
                                .font(.caption)
                                .foregroundColor(.yellow)
                        }
                    }
                }
            }
            .padding(.horizontal,20)
            .padding(.vertical, 12)
        }
        .padding(.vertical, 8)
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
            y: 3
        )
    }
}

struct MonthlySummary_Previews: PreviewProvider {
    static var previews: some View {
        MonthlySummary( transactionViewModel: TransactionViewModel(
            context: PersistenceController.shared.container.viewContext
        ))
    }
}
