//
//  ClothesDetail.swift
//  Joiefull
//
//  Created by Louise Ta on 26/09/2024.
//

import SwiftUI

struct ClothesDetail: View {
    var clothes: Clothes
    @State private var comment: String = ""
    @State private var isShareSheetShowing = false
    
    var body: some View {
        
        GeometryReader { geometry in
            let frame = geometry.size
            
            ScrollView {
                VStack {
                    ZStack {
                        AsyncImage(url: URL(string: clothes.picture.url)) { phase in
                            
                            switch phase {
                            case .failure:
                                Image(systemName: "photo")
                                    .font(.largeTitle)
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                            default:
                                ProgressView()
                            }
                        }
                        .frame(height: frame.height / 1.5)
                        .clipShape(.rect(cornerRadius: 25))
                        .accessibilityHint(Text("\(clothes.picture.description)"))
                        VStack {
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
                                }
                                .sheet(isPresented: $isShareSheetShowing, content: {
                                    ActivityViewController(activityItems: [clothes.name, URL(string: clothes.picture.url)!])
                                })
                            }
                            Spacer()
                            HStack {
                                Spacer()
                                HStack(spacing: 4) {
                                    Image(systemName: "heart")
                                        .font(.body)
                                    Text("\(clothes.likes)")
                                        .font(.body)
                                }
                                .padding(6)
                                .background(Color.white.opacity(0.8))
                                .cornerRadius(16)
                                .shadow(radius: 4)
                                .padding()
                            }
                        }
                    }
                    VStack(alignment: .leading) {
                        HStack {
                            Text(clothes.name)
                                .foregroundStyle( .black)
                                .font(.title3)
                                .bold()
                            Spacer()
                            HStack(spacing: 2) {
                                Image(systemName: "star.fill")
                                    .font(.title3)
                                    .foregroundColor(.orange)
                                Text("4")
                                    .foregroundColor(.black)
                                    .font(.title3)
                            }
                        }
                        HStack {
                            Text("\(String(format: "%.2f", clothes.price))€")
                                .font(.title3)
                                .foregroundColor( .black)
                            Spacer()
                            Text("\(String(format: "%.2f", clothes.original_price))€")
                                .strikethrough()
                                .foregroundColor(.gray)
                                .font(.title3)
                        }
                        HStack {
                            Image(systemName: "person.circle")
                                .font(.title)
                            ForEach(0..<5, id: \.self) { _ in
                                Image(systemName: "star")
                            }
                            .padding(4)
                            Spacer()
                        }
                        Text("Partagez ici vos impressions sur cette pièce")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        TextEditor(text: $comment)
                            .frame(minHeight: 100, maxHeight: 50)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                    }
                }
                .padding()
            }.accessibilityLabel("Detail page with more details about the item")
            
            
            
        }
    }
}

#Preview {
    let testClothes = Clothes(
        id: 1,
        name: "Casual T-Shirt",
        likes: 10,
        price: 29.99,
        original_price: 39.99,
        category: .tops,
        picture: Clothes.Picture(url: "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/img/bottoms/1.jpg",
                                 description: "A casual t-shirt")
    )
    return ClothesDetail(clothes: testClothes)
}
