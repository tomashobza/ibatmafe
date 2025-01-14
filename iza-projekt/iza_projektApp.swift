//
//  iza_projektApp.swift
//  iza-projekt
//
//  Created by Tomáš Hobza on 23.04.2024.
//

import SwiftData
import SwiftUI

@main

struct iza_projektApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Event.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
//        .modelContainer(for: Event.self)
    }
}
