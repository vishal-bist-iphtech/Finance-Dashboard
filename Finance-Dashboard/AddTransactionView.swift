//
//  AddTransactionView.swift
//  Finance-Dashboard
//
//  Created by iPHTech 7 on 07/07/26.
//

import SwiftUI

struct AddTransactionView: View {

    @ObservedObject var viewModel: FinanceViewModel

    @Environment(\.presentationMode) var presentationMode

    @State private var title = ""
    @State private var amount = ""

    @State private var selectedCategory: Category = .food

    @State private var isIncome = false

    var body: some View {

        NavigationView {

            Form {

                Section(header: Text("Transaction Details")) {

                    TextField("Title", text: $title)

                    TextField("Amount", text: $amount)
                        .keyboardType(.decimalPad)

                }

                Section(header: Text("Category")) {

                    Picker("Category", selection: $selectedCategory) {

                        ForEach(Category.allCases) { category in

                            Text(category.rawValue)
                                .tag(category)

                        }

                    }

                }

                Section(header: Text("Transaction Type")) {

                    Toggle(isOn: $isIncome) {

                        Text("Income")

                    }

                }

            }
            .navigationBarTitle("Add Transaction", displayMode: .inline)
            .navigationBarItems(

                leading:

                    Button("Cancel") {

                        presentationMode.wrappedValue.dismiss()

                    },

                trailing:

                    Button("Save") {

                        saveTransaction()

                    }
                    .disabled(title.isEmpty || amount.isEmpty)

            )

        }

    }

    private func saveTransaction() {

        guard let value = Double(amount) else {
            return
        }

        viewModel.addTransaction(
            title: title,
            amount: value,
            category: selectedCategory,
            isIncome: isIncome
        )

        presentationMode.wrappedValue.dismiss()

    }

}

struct AddTransactionView_Previews: PreviewProvider {

    static var previews: some View {

        AddTransactionView(
            viewModel: FinanceViewModel()
        )

    }

}
