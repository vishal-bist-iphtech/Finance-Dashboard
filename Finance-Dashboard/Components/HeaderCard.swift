//
//  HeaderCard.swift
//  Finance-Dashboard
//
//  Created by iPHTech 34 on 13/07/26.
//

import SwiftUI

struct HeaderCard: View {
    
    @Binding var showingAddTransaction: Bool
    @ObservedObject var transactionViewModel: TransactionViewModel
    
    var body: some View {
        ZStack(alignment: .bottom) {

            // MARK: Header Background
            RoundedRectangle(cornerRadius: 28)
                .fill(
                    LinearGradient(
                        colors: [
                            .blue,
                            .indigo
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .padding(.top,-800)
                .padding(-20)
                .frame(height: 220)
                .overlay(alignment: .top) {

                    HStack {

                        VStack(alignment: .leading, spacing: 4) {

                            Text("Finance Dashboard")
                                .font(.title.bold())
                                .foregroundStyle(.white)

                            Text("Track your finances")
                                .font(.title3)
                                .foregroundStyle(.white.opacity(0.8))
                        }
                        .padding()

                        Spacer()

                        Button {

                            showingAddTransaction = true

                        } label: {

                            Image(systemName: "plus")
                                .font(.title3.weight(.semibold))
                                .foregroundStyle(.white)
                                .frame(width: 44, height: 44)
                                .background(.white.opacity(0.2))
                                .clipShape(Circle())
                        }
                        .padding()
                        .sheet(isPresented: $showingAddTransaction) {
                            AddTransactionView(
                                transactionViewModel: transactionViewModel
                            )
                        }

                    }
                }

            // Decorative circles
            .overlay {

                Circle()
                    .fill(.white.opacity(0.08))
                    .frame(width: 180)
                    .offset(x: 120, y: -70)

                Circle()
                    .fill(.white.opacity(0.05))
                    .frame(width: 120)
                    .offset(x: -130, y: 60)
            }

            // MARK: Balance Card
            BalanceCard(transactionViewModel: transactionViewModel)
                .offset(y: 80)

        }
        .padding(.bottom, 80)
    }
}
    

#Preview {
    HeaderCard(showingAddTransaction: .constant(false),
               transactionViewModel: TransactionViewModel(
                   context: PersistenceController.shared.container.viewContext
               )
    )
}
