//
//  SearchBar.swift
//  GoodGames
//
//  Created by Jackson Secrist on 3/15/23.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchString: String
    var body: some View {
        HStack {
                Image(systemName: "magnifyingglass").foregroundColor(.gray)
                TextField("Search", text: $searchString)
                    .font(Font.system(size: 21))
                    .autocorrectionDisabled(true)
                    .autocapitalization(.none)
                    .multilineTextAlignment(.leading)
            }
            .padding(7)
            .background(Color(.systemGray6))
            .cornerRadius(10)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(searchString: .constant("Search me"))
    }
}
