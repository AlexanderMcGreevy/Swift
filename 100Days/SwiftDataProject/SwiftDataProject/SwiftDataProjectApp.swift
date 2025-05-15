//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Alexander McGreevy on 5/15/25.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
