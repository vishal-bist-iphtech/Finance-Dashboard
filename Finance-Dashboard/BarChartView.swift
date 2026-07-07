//
//  BarChartView.swift
//  Finance-Dashboard
//
//  Created by iPHTech 7 on 07/07/26.
//

import SwiftUI

struct BarChartView: View {
    
    let transactions: [Transaction]
    
    private var categoryTotals: [(category: String, total: Double)] {
        
        var totals: [String: Double] = [:]
        
        for transaction in transactions where !transaction.isIncome {
            totals[transaction.category.rawValue, default: 0] += transaction.amount
        }
        
        return totals
            .map { (category: $0.key, total: $0.value) }
            .sorted { $0.total > $1.total }
    }
    
    private var maxAmount: Double {
        categoryTotals.map { $0.total }.max() ?? 1
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Text("Expenses by Category")
                .font(.headline)
                .padding(.bottom)
            
            ForEach(categoryTotals, id: \.category) { item in
                
                VStack(alignment: .leading, spacing: 4) {
                    
                    HStack {
                        
                        Text(item.category)
                            .frame(width: 100, alignment: .leading)
                        
                        GeometryReader { geometry in
                            
                            Rectangle()
                                .fill(Color.blue)
                                .frame(
                                    width: CGFloat(item.total / maxAmount) * geometry.size.width,
                                    height: 18
                                )
                                .cornerRadius(5)
                        }
                        .frame(height: 18)
                    }
                    
                    Text("₹\(item.total, specifier: "%.2f")")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding(.bottom, 10)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(15)
    }
}

struct BarChartView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        BarChartView(
            transactions: [
                Transaction(
                    title: "Pizza",
                    amount: 600,
                    category: .food,
                    isIncome: false,
                    date: Date()
                ),
                Transaction(
                    title: "Burger",
                    amount: 400,
                    category: .food,
                    isIncome: false,
                    date: Date()
                ),
                Transaction(
                    title: "Movie",
                    amount: 800,
                    category: .entertainment,
                    isIncome: false,
                    date: Date()
                ),
                Transaction(
                    title: "Shopping",
                    amount: 2000,
                    category: .shopping,
                    isIncome: false,
                    date: Date()
                )
            ]
        )
        .padding()
    }
}
