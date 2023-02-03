//
//  HorizontalCarousel.swift
//  GoodGames
//
//  Created by Jackson Secrist on 2/2/23.
//

import SwiftUI

struct HorizontalCarousel: View {
    var label: String
    var color: Color
    
    var body: some View {
        Text(label)
            .font(.title2)
            .multilineTextAlignment(.leading)
        ScrollView(.horizontal) {
            HStack {
                ForEach(0..<10) {
                    Text("Item \($0)")
                        .foregroundColor(.white)
                        .frame(width: 100, height: 150)
                        .background(color)
                }
            }
        }
    }
}

struct HorizontalCarousel_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .leading) {
            HorizontalCarousel(label: "New Releases", color: .blue)
        }
        .padding()
    }
}
