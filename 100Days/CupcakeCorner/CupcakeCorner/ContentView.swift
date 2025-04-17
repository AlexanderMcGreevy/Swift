//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Alexander McGreevy on 4/16/25.
//

import SwiftUI

struct ContentView: View {
    @State private var username = ""
    @State private var email = ""

    var body: some View {
        var disableForm: Bool {
            username.count < 5 || email.count < 5
        }
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }

            Section {
                Button("Create account") {
                    print("Creating account…")
                }
            }.disabled(disableForm)


        }
    }
}


#Preview {
    ContentView()
}
