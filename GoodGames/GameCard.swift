//
//  GameCard.swift
//  GoodGames
//
//  Created by Jackson Secrist on 2/22/23.
//

import SwiftUI

struct GameCard: View {
    @Binding var tabSelection: Int
    var text: String
    var color: Color
    var body: some View {
        NavigationLink {
            GameProfileView(tabSelection: $tabSelection)
        } label: {
            card
        }
    }
    
    var card: some View {
        Text(text)
            .foregroundColor(.white)
            .frame(width: 100, height: 150)
            .background(color)
    }
}

struct GameCard_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            GameCard(tabSelection: .constant(1), text: "Item 0", color: .green)
        }
    }
}
