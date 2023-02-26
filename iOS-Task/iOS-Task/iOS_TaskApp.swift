//
//  iOS_TaskApp.swift
//  iOS-Task
//
//  Created by Kullanici on 26.02.2023.
//

import SwiftUI

@main
struct iOS_TaskApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
