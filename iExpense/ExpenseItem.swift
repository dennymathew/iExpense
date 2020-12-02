//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Denny Mathew on 02/12/20.
//

import Foundation
struct ExpenseItem: Identifiable, Codable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Int
}
class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.setValue(encoded, forKey: "Items")
            }
        }
    }
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items"), let decoded = try? JSONDecoder().decode([ExpenseItem].self, from: items) {
            self.items = decoded
            return
        }
        self.items = []
    }
}
