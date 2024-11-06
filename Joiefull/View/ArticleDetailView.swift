//
//  ArticleDetailView.swift
//  Joiefull
//
//  Created by Louise Ta on 26/09/2024.
//

import SwiftUI

struct ArticleDetailView: View {
    @ObservedObject var viewModel: ArticleDetailViewModel
    
    @State private var isShareSheetShowing = false
    
    var body: some View {
        GeometryReader { geometry in
            let frame = geometry.size
            ScrollView {
                VStack {
                    ZStack {
                        AsyncImage(url: URL(string: viewModel.article.picture.url)) { phase in
                            switch phase {
                            case .failure:
                                Image(systemName: "photo")
                                    .font(.largeTitle)
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .clipped()
                            default:
                                ProgressView()
                            }
                        }
                        .frame(width: frame.width - 30, height: frame.height * 0.6)
                        .clipShape(.rect(cornerRadius: 25))
                        .accessibilityElement()
                        .accessibilitySortPriority(3)
                        .accessibilityHint(Text("\(viewModel.article.picture.description)"))
                        
                        VStack {
                            if let url = URL(string: viewModel.article.picture.url) {
                                HStack {
                                    Spacer()
                                    Button(action: {
                                        isShareSheetShowing = true
                                    }) {
                                        Image("ShareIcon")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 25)
                                            .padding(10)
                                            .background(Color.white.opacity(0.8))
                                            .clipShape(.rect(cornerRadius: 20))
                                            .shadow(radius: 4)
                                            .padding()
                                            .accessibilityLabel("Partager l'article")
                                    }
                                    .sheet(isPresented: $isShareSheetShowing, content: {
                                        ActivityViewController(activityItems: [viewModel.article.name, url])
                                    })
                                }
                            }
                        
                            Spacer()
                            HStack {
                                Spacer()
                                LikesView(like: viewModel.like)
                                    .padding()
                            }
                        }
                    }
                    VStack(alignment: .leading) {
                        HStack {
                            Text(viewModel.article.name)
                                .foregroundStyle(Color.primary)
                                .font(.title3)
                                .bold()
                                .accessibilitySortPriority(4)

                            Spacer()
                            HStack(spacing: 2) {
                                Image(systemName: "star.fill")
                                    .font(.title3)
                                    .foregroundColor(.orange)
                                Text(getHumanReadableRating())
                                    .foregroundColor(.primary)
                                    .font(.title3)
                            }
                            .accessibilityElement(children: .ignore)
                            .accessibilitySortPriority(1)
                            .accessibilityLabel("L'article a une moyenne de \(getHumanReadableRating()) étoiles sur 5")
                        }
                        HStack {
                            Text("\(String(format: "%.2f", viewModel.article.price))€")
                                .font(.title3)
                                .foregroundStyle(Color.secondary)
                            Spacer()
                            Text("\(String(format: "%.2f", viewModel.article.originalPrice))€")
                                .strikethrough()
                                .foregroundStyle(Color.secondary)
                                .font(.title3)
                        }
                        .accessibilityElement(children: .ignore)
                        .accessibilitySortPriority(2)
                        .accessibilityLabel(Text("Le prix actuel est de \(String(format: "%.2f", viewModel.article.price))€ et était de \(String(format: "%.2f", viewModel.article.originalPrice))€"))
                        
                            HStack {
                                Image(systemName: "person.circle")
                                    .font(.title)
                                    .accessibilityHidden(true)
                                RatingView(rating: $viewModel.userRating)
                                    .padding(4)
                                Spacer()
                            }
                            Text("Partagez ici vos impressions sur cette pièce")
                                .font(.subheadline)
                                .foregroundStyle(Color.secondary)
                            
                            TextEditor(text: $viewModel.userComment)
                                .foregroundStyle(.secondary)
                                .frame(height: frame.height / 8)
                                .padding(.horizontal)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                                .accessibilityElement()
                                .accessibilityLabel("Rédigez le commentaire ici")
                            Button(action: {
                                viewModel.addReview()
                                viewModel.updateAverageRating()
                            }) {
                                Text("Send")
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.orange)
                                    .foregroundColor(.white)
                                    .cornerRadius(30)
                            }
                    }
                }
                .padding(15)
                .accessibilityElement(children: .contain)
            }
        }
    }
    
    private func getHumanReadableRating() -> String {
        guard let rating = viewModel.averageRating else {
            return "No rating"
        }
        
        return String(format: "%.1f", rating)
    }
}

#Preview {
    let testArticle = Article(
        id: 1,
        name: "Casual T-Shirt",
        likes: 10,
        price: 29.99,
        originalPrice: 39.99,
        category: Article.Category.tops,
        picture: Article.Picture(
            url: "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/img/accessories/2.jpg",
            description: "A casual t-shirt"
        )
    )
    return ArticleDetailView(
        viewModel: ArticleDetailViewModel(
            article: testArticle,
            like: Like(likes: 42, isLiked: false),
            reviewRepository: ReviewRepository(
                viewContext: PersistenceController().container.viewContext
            )
        )
    )
}
