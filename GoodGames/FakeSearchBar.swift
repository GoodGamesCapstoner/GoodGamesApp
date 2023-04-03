//
//  FakeSearchBar.swift
//  GoodGames
//
//  Created by Jackson Secrist on 3/16/23.
//

import SwiftUI

struct FakeSearchBar: View {
    @State private var fakeSearch = ""
    var body: some View {
        HStack {
                Image(systemName: "magnifyingglass").foregroundColor(.gray)
                TextField("Search", text: $fakeSearch)
                    .font(Font.system(size: 21))
                    .autocorrectionDisabled(true)
                    .autocapitalization(.none)
                    .multilineTextAlignment(.leading)
            }
            .padding(7)
            .background(Color.secondaryBackground)
            .cornerRadius(10)
    }
}

struct FakeSearchBar_Previews: PreviewProvider {
    static var previews: some View {
        FakeSearchBar()
    }
}
