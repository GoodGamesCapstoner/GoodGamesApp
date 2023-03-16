//
//  PlaceholderCard.swift
//  GoodGames
//
//  Created by Jackson Secrist on 3/3/23.
//

import SwiftUI

struct PlaceholderCard: View {
    var label: String
    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: "gamecontroller")
                .font(.largeTitle)
            Spacer()
            Text(label)
                .font(.system(size: 15))
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
        }
        .padding(.vertical)
        .padding(.horizontal, 5)
        .frame(width: 100, height: 150)
        .foregroundColor(.white)
        .background(Color.purpleGG)
    }
}

struct PlaceholderCard_Previews: PreviewProvider {
    static var previews: some View {
        PlaceholderCard(label: "STAR WARS: Jedi Knight: Dark Forces II")
    }
}
