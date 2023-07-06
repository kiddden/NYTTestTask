//
//  CategoryItemView.swift
//  NYTTestTask
//
//  Created by Eugene Ned on 06.07.2023.
//

import SwiftUI

struct CategoryItemView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    let name: String
    let date: String
    
    var body: some View {
        HStack {
            Text(name)
                .multilineTextAlignment(.leading)
                .font(.callout)
            Spacer()
            VStack(alignment: .trailing) {
                Text("published date:")
                Text(date)
            }
            .font(.footnote)
            
        }
        .frame(height: UIScreen.main.bounds.height/20)
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(10)
        .padding(.horizontal, 12)
        .shadow(radius: 5, x: 0, y: 0)
        .foregroundColor(colorScheme == .dark ? .white : .black)
    }
}

struct CategoryItemView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryItemView(name: "Science Fiction", date: "2023-12-14")
    }
}
