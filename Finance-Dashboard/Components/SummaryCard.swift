//
//  SummaryCard.swift
//  Finance-Dashboard
//
//  Created by iPHTech 34 on 13/07/26.
//

import SwiftUI

struct SummaryCard: View {
    
    let title: String
    let amount: Double
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(color)
                
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Text("₹\(amount, specifier: "%.0f")")
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundStyle(amount >= 0 ? .primary : Color.red)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    SummaryCard(title: "Total Income", amount: 5000, icon: "arrow.down.circle.fill", color: .green)
}
