//
//  wakkuApp.swift
//  wakku
//
//  Created by Mark Strijdom on 30/01/2024.
//

import SwiftData
import SwiftUI

@main
struct wakkuApp: App {
    let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for: Video.self, Keyword.self, migrationPlan: DatabaseMigrationPlan.self)
        } catch {
            fatalError("Failed to initialise model container.")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                VideosView()
            }
        }
        .modelContainer(container)
    }
}
