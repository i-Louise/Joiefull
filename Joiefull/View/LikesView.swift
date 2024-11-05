//
//  LikesView.swift
//  Joiefull
//
//  Created by Louise Ta on 29/10/2024.
//

import SwiftUI

struct LikesView: View {
    @ObservedObject var like: Like
    
    var body: some View {
        Button(action: {
            like.toggleLike()
        }) {
            HStack(spacing: 4) {
                Image(systemName: like.isLiked ? "heart.fill" : "heart")
                    .font(.body)
                    .foregroundColor(like.isLiked ? .red : .black)
                Text("\(like.totalLikes)")
                    .font(.body)
            }
        }
        .padding(6)
        .background(Color.white)
        .cornerRadius(30)
        .shadow(radius: 10)
        .padding([.bottom, .trailing], 8)
    }
}
