//
//  CategoryItem.swift
//  Joiefull
//
//  Created by Louise Ta on 23/09/2024.
//

import SwiftUI

struct CategoryItem: View {
    var clothes: Clothes
    
    var body: some View {
        VStack(alignment: .leading) {
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
            .frame(width: 200, height: 200)
            .clipShape(.rect(cornerRadius: 25))
            
            VStack {
                HStack {
                    Text(clothes.name)
                        .font(.system(size: 14))
                        .foregroundStyle(.black)
                    Spacer()
                    HStack(spacing: 2) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.orange)
                        Text("4")
                            .foregroundColor(.gray)
                            .font(.system(size: 14))

                    }
                }
                HStack {
                    Text("\(String(format: "%.2f", clothes.price))€")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.black)
                    Spacer()
                    Text("\(String(format: "%.2f", clothes.original_price))€")
                        .strikethrough()
                        .foregroundColor(.gray)
                        .font(.system(size: 14))
                }
            }
        }
        .padding(.leading, 15)
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
        picture: Clothes.Picture(url: "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/img/accessories/3.jpg",
            description: "A casual t-shirt")
    )

    return CategoryItem(clothes: testClothes)
}
