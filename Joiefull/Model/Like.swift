//
//  Like.swift
//  Joiefull
//
//  Created by Louise Ta on 29/10/2024.
//

import Foundation

class Like: ObservableObject {
    @Published private(set) var isLiked: Bool
    @Published private(set) var totalLikes: Int
    
    init(likes: Int, isLiked: Bool) {
        self.totalLikes = likes
        self.isLiked = isLiked
    }
    
    func toggleLike() {
        if isLiked {
            totalLikes -= 1
        } else {
            totalLikes += 1
        }
        isLiked.toggle()
    }
}
