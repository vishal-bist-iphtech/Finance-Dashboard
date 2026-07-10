import SwiftUI

struct SummaryCard: View {
    
    let title: String
    let amount: Double
    let color: Color
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
            
            Text("₹\(amount, specifier: "%.2f")")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(color)
        .cornerRadius(15)
        .shadow(radius: 4)
    }
}

struct SummaryCard_Previews: PreviewProvider {
    static var previews: some View {
        
        SummaryCard(
            title: "Balance",
            amount: 45200,
            color: .blue
        )
        .padding()
    }
}
