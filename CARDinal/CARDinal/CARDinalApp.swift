//
//  CARDinalApp.swift
//  CARDinal
//
//  Created by Alexander McGreevy on 9/30/25.
//

import SwiftUI

@main
struct CARDinalApp: App {
    @StateObject private var store = CardStore()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
    }
}
