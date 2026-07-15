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
    @AppStorage("isDarkMode")
    private var isDarkMode = false

    var body: some View {

        ZStack(alignment: .top) {

            // MARK: Background Card
            RoundedRectangle(cornerRadius: 32)
                .fill(
                    LinearGradient(
                        colors: [.blue, .indigo],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .padding(.top, -300)
                .frame(height: 250)
                .overlay(alignment: .topTrailing) {

                    Circle()
                        .fill(.primary.opacity(0.08))
                        .frame(width: 180)
                        .offset(x: 60, y: -40)
                        .allowsHitTesting(false)

                }
                .overlay(alignment: .bottomLeading) {

                    Circle()
                        .fill(.primary.opacity(0.05))
                        .frame(width: 120)
                        .offset(x: -30, y: 40)
                        .allowsHitTesting(false)

                }

            VStack(spacing: 0) {

                // MARK: Header

                HStack {

                    VStack(alignment: .leading, spacing: 4) {

                        Text("Finance Dashboard")
                            .font(.title.bold())
                            .foregroundStyle(.white)

                        Text("Track your finances")
                            .font(.subheadline)
                            .foregroundStyle(.white.opacity(0.85))

                    }

                    Spacer()
                    
                    Button {
                        withAnimation(.easeInOut(duration: 0.25)) {
                            isDarkMode.toggle()
                        }
                    } label: {
                        Image(systemName: isDarkMode ? "sun.max.fill": "moon.fill")
                            .font(.title3.weight(.semibold))
                            .foregroundStyle(isDarkMode ? .white : .black)
                            .frame(width: 44, height: 44)
                            .background(.white.opacity(0.2))
                            .clipShape(Circle())
                    }

                    Button {

                        showingAddTransaction = true

                    } label: {

                        Image(systemName: "plus")
                            .font(.title3.weight(.bold))
                            .foregroundStyle(.primary)
                            .frame(width: 46, height: 46)
                            .background(.white.opacity(0.20))
                            .clipShape(Circle())

                    }

                }
                .padding(.horizontal, 24)
                .padding(.top, 24)

                Spacer()

            }

            // MARK: Balance Card

            BalanceCard(transactionViewModel: transactionViewModel)
                .padding(.horizontal, 20)
                .offset(y: 140)

        }
        .frame(height: 330)
    }
}

#Preview {

    HeaderCard(
        showingAddTransaction: .constant(false),
        transactionViewModel: TransactionViewModel(
            context: PersistenceController.shared.container.viewContext
        )
    )

}
