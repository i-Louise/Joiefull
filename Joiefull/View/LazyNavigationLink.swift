//
//  LazyNavigationLink.swift
//  Joiefull
//
//  Created by Louise Ta on 27/10/2024.
//

import SwiftUI

struct LazyNavigationLink<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}
