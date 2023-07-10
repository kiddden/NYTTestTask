//
//  BuyLinkItem.swift
//  NYTTestTask
//
//  Created by Eugene Ned on 10.07.2023.
//

import SwiftUI

struct BuyLinkItem: View {
    let buyLink: BuyLink
    
    let action: (BuyLink) -> ()
    
    init(for buyLink: BuyLink, action: @escaping (BuyLink) -> ()) {
        self.buyLink = buyLink
        self.action = action
    }
    
    var body: some View {
        HStack {
            Text(buyLink.name)
                
            Spacer()
            
            Button {
                action(buyLink)
            } label: {
                Text(L10n.Books.buyButton)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding(Constants.padding)
        .background(.ultraThinMaterial)
        .cornerRadius(Constants.cornerRadius)
        .padding(.horizontal, Constants.padding*2)
        .shadow(radius: 2, x: 0, y: 0)
    }
    
    enum Constants {
        static let cornerRadius: CGFloat = 10
        static let padding: CGFloat = 6
    }
}

//struct BuyLinkItem_Previews: PreviewProvider {
//    static var previews: some View {
//        BuyLinkItem()
//    }
//}
