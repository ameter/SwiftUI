//
//  ContentView.swift
//  BucketList
//
//  Created by Chris on 4/30/20.
//  Copyright © 2020 CodePika. All rights reserved.
//

import LocalAuthentication
import SwiftUI

struct ContentView: View {
    @State private var isUnlocked = false
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        ZStack {
            if isUnlocked {
                UnlockedView()
            } else {
                Button("Unlock places") {
                    self.authenticate()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text(alertTitle), message: Text(alertMessage))
                }
            }
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authenticate yourself to unlock your places."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        // error
                        self.alertTitle = "Authentication Failed"
                        self.alertMessage = authenticationError?.localizedDescription ?? "Unknown error"
                        self.showingAlert = true
                    }
                }
            }
        } else {
            // no biometrics
            self.alertTitle = "Authentication Error"
            self.alertMessage = error?.localizedDescription ?? "Unknown error"
            self.showingAlert = true
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
