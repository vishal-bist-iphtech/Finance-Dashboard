//
//  DonutChartView.swift
//  Finance-Dashboard
//
//  Created by iPHTech 7 on 09/07/26.
//

import SwiftUI

struct DonutChart: View {
    
    let data: [ExpenseCategory]
    let donutHoleRatio: CGFloat = 0.3
    @State private var selectedIndex: Int? = nil
    @State private var animateChart: Bool = false
    @State private var showToolTip: Bool = false
    @State private var toolTipPositoin: CGPoint = .zero
    
    private var total: Double {
        data.reduce(0){$0 + $1.value}
    }
    
    var body: some View {
        
        GeometryReader { geometry in

            let size = min(geometry.size.width, geometry.size.height)
            let holeSize = size * donutHoleRatio

            ZStack {
                if data.isEmpty {

                    Text("No expense data")
                        .foregroundColor(.gray)

                } else {

                    ForEach(Array(data.enumerated()), id: \.element.id) { index, item in
                        // Calculate the start and end angles for this segment
                        let startAngle = startingAngle(for: index)
                        let endAngle = endingAngle(for: index)

                        // Custom shape for the arc
                        PieSliceShape(startAngle: startAngle, endAngle: endAngle)
                            .fill(item.color)
                            .overlay(
                                // 3. Add a subtle border between segments
                                PieSliceShape(startAngle: startAngle, endAngle: endAngle)
                                    .stroke(Color.white, lineWidth: 1)
                            )
                    }
                    // Add the center "hole" for the donut effect
                    Circle()
                        .fill(Color.gray)
                        .frame(width: holeSize, height: holeSize)
                    Circle()
                        .fill(Color(UIColor.systemBackground))
                        .frame(width: holeSize-5, height: holeSize-5)
                        .overlay(
                            VStack {
                            
                                Text("Total")
                                    .font(.subheadline)

                                Text("₹\(total, specifier: "%.0f")")
                                    .font(.caption)

                        })
                }
            }
            .padding(.horizontal)
            
            
    }
        .aspectRatio(1, contentMode: .fit)
}
    

// Helper functions to calculate angles
private func startingAngle(for index: Int) -> Angle {
    let previousTotal = data[..<index].reduce(0) { $0 + $1.value }
    let percentage = previousTotal / total
    return .degrees(percentage * 360 - 90) // Start from top (12 o'clock)
}

private func endingAngle(for index: Int) -> Angle {
    let currentTotal = data[...index].reduce(0) { $0 + $1.value }
    let percentage = currentTotal / total
    return .degrees(percentage * 360 - 90)
    }
}

// Custom Shape to draw a pie slice
struct PieSliceShape: Shape {
    let startAngle: Angle
    let endAngle: Angle

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2

        path.move(to: center)
        path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        path.closeSubpath()

        return path
    }
}

struct DonutChart_Previews: PreviewProvider {
    static var previews: some View {
        DonutChart(data: [ExpenseCategory(name:"food",value:2000,color:.red),
                              ExpenseCategory(name:"travel",value:4000,color:.blue),
                              ExpenseCategory(name:"shopping",value:12000,color:.yellow),
                              ExpenseCategory(name:"bills",value:22000,color:.orange)])
    }
}
