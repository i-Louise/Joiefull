//
//  JoiefullApp.swift
//  Joiefull
//
//  Created by Louise Ta on 23/09/2024.
//

import SwiftUI

@main
struct JoiefullApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
        }
    }
}
