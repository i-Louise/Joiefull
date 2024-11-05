//
//  RatingView.swift
//  Joiefull
//
//  Created by Louise Ta on 11/10/2024.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
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
                    starImage.foregroundStyle(currentStarIndex < (rating ) ? onColor : offColor)
                }
            }
        }
        .accessibilityElement()
        .accessibilityLabel("Notation sur 5 étoiles")
        .accessibilityValue(String(rating))
        .accessibilityAdjustableAction { direction in
            switch direction {
            case .increment:
                guard rating < maximumRating else { break }
                rating += 1
            case .decrement:
                guard rating > 1 else { break }
                rating -= 1
            @unknown default:
                break
            }
        }
    }
}

#Preview {
    RatingView(rating: .constant(4))
}
