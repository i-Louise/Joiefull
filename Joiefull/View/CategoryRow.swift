//
//  CategoryRow.swift
//  Joiefull
//
//  Created by Louise Ta on 23/09/2024.
//

import SwiftUI

struct CategoryRow: View {
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Haut")
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    CategoryItem()
                    CategoryItem()
                }
            }
            
        }
    }
}

#Preview {
    CategoryRow()
}
