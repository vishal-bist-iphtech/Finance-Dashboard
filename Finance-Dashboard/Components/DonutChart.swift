import SwiftUI
import Charts

struct DonutChart: View {

    let data: [ExpenseCategory]
    
    @State private var selectedAngle: Double?

    private var total: Double {
        data.reduce(0) { $0 + $1.value }
    }
    
    private var selectedCategory: ExpenseCategory? {
        guard
            let selectedAngle = selectedAngle,
            total > 0
        else {
            return nil
        }
        
        var cumulative = 0.0
        
        for category in data {
            cumulative += category.value
            
            if selectedAngle <= cumulative {
                return category
            }
        }
        
        return nil
        
    }

    var body: some View {
        
        ZStack {
            
            if data.isEmpty {
                
                ContentUnavailableView(
                    "No Expense Data",
                    systemImage: "chart.pie"
                )
                
            } else {
                
                Chart(data) { item in
                    
                    SectorMark(
                        angle: .value("Amount", item.value),
                        innerRadius: .ratio(0.3),
                        outerRadius: .ratio(selectedCategory?.id == item.id ? 1.05 : 0.9),
                        angularInset: 0.5
                    )
                    .foregroundStyle(item.color)
                    
                }
                .chartLegend(.hidden)
                .chartAngleSelection(value: $selectedAngle)
                .chartBackground { _ in
                    
                    VStack(spacing: 4) {
                        
                        if let selected = selectedCategory {
                            
                            Text(selected.name)
                                .font(.system(size: 12))
                                .lineLimit(2)
                            
                            Text("₹\(selected.value, specifier: "%.0f")")
                                .font(.subheadline)
                                .fontWeight(.bold)
                            
                            Text(
                                "\(selected.value / total * 100, specifier: "%.0f")%"
                            )
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            
                        } else {
                            
                            Text("Total")
                                .font(.headline)
                            
                            Text("₹\(total, specifier: "%.0f")")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .minimumScaleFactor(0.7)
                            
                        }
                    }
                    .onTapGesture {
                        withAnimation(.spring()) {
                            selectedAngle = nil
                        }
                    }
                    .frame(width: 90, height: 90)
                    .padding()
                }
                .animation(.spring(response: 0.35), value: selectedCategory?.id)
                .frame(height: 260)
            }
        }
    }
    
}

#Preview {
    DonutChart(
        data: [
            ExpenseCategory(name: "Food", value: 2000, color: .red),
            ExpenseCategory(name: "Travel", value: 4000, color: .blue),
            ExpenseCategory(name: "Shopping", value: 12000, color: .yellow),
            ExpenseCategory(name: "Bills", value: 22000, color: .orange)
        ]
    )
}
