//
//  CategoryRow.swift
//  Finance-Dashboard
//
//  Created by iPHTech 34 on 13/07/26.
//

import SwiftUI

struct CategoryRow: View {
    let category: ExpenseCategory
    let total: Double
    
    private var percentage: Double {
        guard total > 0 else { return 0 }
        return (category.value / total) * 100
    }
    
    var body: some View {
        VStack(spacing: 4) {
            HStack {
                Circle()
                    .fill(category.color)
                    .frame(width: 10, height: 10)
                
                Text(category.name)
                    .font(.subheadline)
                Text("(\(percentage, specifier: "%.0f")%)")
                    .font(.subheadline)
                    .foregroundColor(Color(.secondaryLabel))
                
                Spacer()
                
                Text("₹\(category.value, specifier: "%.0f")")
                    .font(.subheadline.weight(.medium))
            }
        }
    }
}

#Preview {
        let sampleCategories = [
        ExpenseCategory(name: "Food", value: 500, color: .blue),
        ExpenseCategory(name: "Travel", value: 300, color: .green),
        ExpenseCategory(name: "Entertainment", value: 200, color: .purple)
    ]
    
        return VStack(spacing: 16) {
        ForEach(sampleCategories, id: \.name) { category in
            CategoryRow(
                category: category,
                total: 1500
            )
            .padding(.horizontal)
        }
    }
    .padding(.vertical)
    .background(Color(.systemGroupedBackground)
    )
}
