//
//  ContentView.swift
//  iExpense
//
//  Created by Denny Mathew on 24/11/20.
//

import SwiftUI
struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        Text("$\(item.amount)")
                            .font(.title)
                    }
                }
                .onDelete(perform: self.removeItems)
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(trailing:
                                    HStack {
                                        Button(action: {
                                            self.showingAddExpense = true
                                        }, label: {
                                            Image(systemName: "rectangle.stack.badge.plus")
                                        })
                                        EditButton()
                                    })
        }
        .sheet(isPresented: $showingAddExpense, content: {
            AddView(expenses: self.expenses)
        })
    }
    func removeItems(at offset: IndexSet) {
        expenses.items.remove(atOffsets: offset)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
