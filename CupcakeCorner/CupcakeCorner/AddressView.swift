//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Chris on 4/24/20.
//  Copyright © 2020 CodePika. All rights reserved.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: OrderWrapper
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.details.name)
                TextField("Street Address", text: $order.details.streetAddress)
                TextField("City", text: $order.details.city)
                TextField("Zip", text: $order.details.zip)
            }

            Section {
                NavigationLink(destination: CheckoutView(order: order)) {
                    Text("Check out")
                }
            }
            .disabled(!order.details.hasValidAddress)
        }
        .navigationBarTitle("Delivery details", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: OrderWrapper())
    }
}
