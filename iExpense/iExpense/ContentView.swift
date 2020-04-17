//
//  ContentView.swift
//  iExpense
//
//  Created by Chris on 4/16/20.
//  Copyright © 2020 CodePika. All rights reserved.
//



import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Int
}

class Expenses: ObservableObject {
    @Published var items: [ExpenseItem] //{
//  The following code was removed because the didSet property observer currently does NOT fire on a property with the @Published property wrapper.
//
//  The alternative is to either oberve the property in the stuct directly (if not using an array), OR apply .onReceive(expenses.$items) { items in } to any view that receives the notification of the update (see below for an example).
//
//        didSet {
//            print("trying to write items")
//            let encoder = JSONEncoder()
//            if let encoded = try? encoder.encode(items) {
//                print("writing items")
//                UserDefaults.standard.set(encoded, forKey: "Items")
//            }
//        }
//    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            if let decoded = try?  decoder.decode([ExpenseItem].self, from: items) {
                self.items = decoded
                return
            }
        }
        
        self.items = []
    }
}


struct ExpenseStyleModifier: ViewModifier {
    let amount: Int
    
    func body(content: Content) -> some View {
        switch amount {
        case ..<10:
            return content
                .foregroundColor(.red)
        case ..<100:
            return content
                .foregroundColor(.black)
        default:
            return content
                .foregroundColor(.green)
        }
    }
}

extension View {
    func expenseStyle(amount: Int) -> some View {
        self.modifier(ExpenseStyleModifier(amount: amount))
    }
}

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
                        
                        Text("\(item.amount)")
                            .expenseStyle(amount: item.amount)
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(leading: EditButton(),
                trailing: Button(action: {
                    self.showingAddExpense = true
                }) {
                    Image(systemName: "plus")
                }
            )
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: self.expenses)
            }
            .onReceive(expenses.$items) { items in
                // This is used as a workaround to write to UserDefaults every time the items property of the expenses class is updated.
                // This is necessary because the didSet property observer currently does NOT fire on a property with the @Published property wrapper.
                let encoder = JSONEncoder()
                if let encoded = try? encoder.encode(items) {
                    UserDefaults.standard.set(encoded, forKey: "Items")
                }
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
