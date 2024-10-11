//
//  JoiefullApp.swift
//  Joiefull
//
//  Created by Louise Ta on 23/09/2024.
//

import SwiftUI

@main
struct JoiefullApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ClothesHome(viewModel: ClothesViewModel(context: persistenceController.container.viewContext))
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
