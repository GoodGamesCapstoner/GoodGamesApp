//
//  GameProfile.swift
//  GoodGames
//
//  Created by Jackson Secrist on 2/3/23.
//

import SwiftUI

struct GameProfile: View {
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 0) {
                AsyncImage(url: URL(string: Constants.hero_url)) { image in
                    image.resizable()
                } placeholder: {
                    //nothin yet
                }
                .edgesIgnoringSafeArea(.top)
                .frame(width: geometry.size.width, height: 150)
                .border(.red)
                Text("Deep Rock Galactic")
                    .foregroundColor(.black)
                    .font(.largeTitle)
                    .background(.white)
                    .padding(3)
                    .border(.black, width: 3)
                
                Spacer()
            }
        }
        
    }
}

fileprivate struct Constants {
    static let hero_url: String = "https://cdn2.steamgriddb.com/file/sgdb-cdn/thumb/e5520e0a26c349b166bb72c155a54d21.jpg"
}

struct GameProfile_Previews: PreviewProvider {
    static var previews: some View {
        GameProfile()
    }
}
