//
//  HorizontalCarousel.swift
//  GoodGames
//
//  Created by Jackson Secrist on 2/2/23.
//

import SwiftUI

struct HorizontalCarousel<Content: View>: View {
    var label: String
    @ViewBuilder var content: Content
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.title2)
                .multilineTextAlignment(.leading)
            ScrollView(.horizontal) {
                HStack {
                    content
                }
            }
        }
    }
}

struct HorizontalCarousel_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalCarousel(label: "New Releases") {
            ForEach(0..<10) {
                Text("Item \($0)")
                    .foregroundColor(.white)
                    .frame(width: 100, height: 150)
                    .background(.blue)
            }
        }
        .padding()
    }
}
