//
//  JoiefullApp.swift
//  Joiefull
//
//  Created by Louise Ta on 23/09/2024.
//

import SwiftUI

@main
struct JoiefullApp: App {
    private let appViewModel = JoiefullAppViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView(articleListViewModel: appViewModel.articleListViewModel)
        }
    }
}
