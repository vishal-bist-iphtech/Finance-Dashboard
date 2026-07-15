import SwiftUI

struct BalanceCard: View {
    
    @ObservedObject var transactionViewModel: TransactionViewModel
    
    var body: some View {
        
        VStack(spacing: 20) {

            VStack(spacing: 6) {

                Text("Total Balance")
                    .font(.headline)
                    .foregroundStyle(.primary)

                Text("₹\(transactionViewModel.totalBalance, specifier: "%.0f")")
                    .font(.system(size: 34, weight: .bold))
            }

            Divider()
                .overlay(Color.secondary.opacity(0.3))

            HStack(spacing: 20) {

                // Income
                HStack(spacing: 10) {

                    Image(systemName: "arrow.down.circle.fill")
                        .font(.title2)
                        .foregroundStyle(.green)

                    VStack(alignment: .leading, spacing: 4) {

                        Text("Income")
                            .font(.subheadline)
                            .bold()
                            .foregroundStyle(.secondary)

                        Text("₹\(transactionViewModel.totalIncome, specifier: "%.0f")")
                            .font(.headline)
                    }
                }
            
                Spacer()
                // Expense
                HStack(spacing: 12) {

                    Image(systemName: "arrow.up.circle.fill")
                        .font(.title2)
                        .foregroundStyle(.red)

                    VStack(alignment: .leading, spacing: 4) {

                        Text("Expense")
                            .font(.subheadline)
                            .bold()
                            .foregroundStyle(.secondary)

                        Text("₹\(transactionViewModel.totalExpense, specifier: "%.0f")")
                            .font(.headline)
                    }
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.secondarySystemBackground))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color(.secondarySystemBackground), lineWidth: 1)
        )
        .shadow(color: .secondary, radius: 10, x: 0, y: 5)
        .padding(.horizontal)
    }
}

#Preview {
    BalanceCard(transactionViewModel: TransactionViewModel(
        context: PersistenceController.shared.container.viewContext
    ))
}
