//
//  RatingView.swift
//  Joiefull
//
//  Created by Louise Ta on 11/10/2024.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int?
    
    private let maximumRating = 5
    private let starImage = Image(systemName: "star.fill")
    private let offColor = Color.gray
    private let onColor = Color.yellow
    
    var body: some View {
        HStack {
            ForEach(0..<maximumRating, id: \.self) { currentStarIndex in
                Button {
                    self.rating = currentStarIndex + 1
                } label: {
                    starImage.foregroundStyle(currentStarIndex < (rating ?? 0) ? onColor : offColor)
                }
            }
        }
    }
}

#Preview {
    RatingView(rating: .constant(4))
}
