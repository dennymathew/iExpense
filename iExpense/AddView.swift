//
//  AddView.swift
//  iExpense
//
//  Created by Denny Mathew on 02/12/20.
//

import SwiftUI
struct AddView: View {
    @ObservedObject var expenses: Expenses
    @Environment(\.presentationMode) var presentationMode
    @State private var name = ""
    @State private var type = types.first ?? ""
    @State private var amount = ""
    private static let types = ["Personal", "Business"]
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Select type", selection: $type) {
                    ForEach(AddView.types, id:\.self) {
                        Text($0)
                    }
                }
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add new expense")
            .navigationBarItems(trailing:
                                    Button(action: {
                                        if let actualAmount = Int(self.amount) {
                                            let expenseItem = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                                            self.expenses.items.append(expenseItem)
                                            presentationMode.wrappedValue.dismiss()
                                        }
                                    }, label: {
                                        Image(systemName: "hand.thumbsup")
                                    })
            )
        }
    }
}
struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}

