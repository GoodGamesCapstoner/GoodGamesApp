//
//  ExtendedGameCard.swift
//  GoodGames
//
//  Created by Jackson Secrist on 2/15/23.
//

import SwiftUI

struct ExtendedGameCard: View {
    var body: some View {
        HStack {
            VStack {
                Text("The Elder Scrolls V: Skyrim Special Edition")
                    .font(.headline)
                Spacer()
                Text("The Elder Scrolls V: Skyrim is an action role-playing video game developed by Bethesda Game Studios and published by Bethesda Softworks.")
                    .font(.footnote)
            }
            
            Spacer()
            
            Text("Game")
                .foregroundColor(.white)
                .frame(width: 100, height: 150)
                .background(.black)
        }
        .frame(maxWidth: 350, maxHeight: 150)
        .padding()
        .background(.gray)
        .cornerRadius(5)
    }
}

struct ExtendedGameCard_Previews: PreviewProvider {
    static var previews: some View {
        ExtendedGameCard()
            .padding()
    }
}
