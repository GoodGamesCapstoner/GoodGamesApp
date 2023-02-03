//
//  DiscoverView.swift
//  GoodGames
//
//  Created by Jackson Secrist on 1/31/23.
//

import SwiftUI

struct DiscoverView: View {
    @State var searchString: String = ""
    
    var body: some View {
        VStack {
            Text("Discovery")
                .font(.largeTitle)
                .padding(.top)
            
            SearchBar(searchString: $searchString)
                .padding(.leading, 15)
                .padding(.trailing, 15)
            Spacer()
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Recommended")
                        .font(.title2)
                        .multilineTextAlignment(.leading)
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(0..<10) {
                                Text("Item \($0)")
                                    .foregroundColor(.white)
                                    .frame(width: 100, height: 150)
                                    .background(.blue)
                            }
                        }
                    }
                    
                    Text("Featured")
                        .font(.title2)
                        .multilineTextAlignment(.leading)
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(0..<10) {
                                Text("Item \($0)")
                                    .foregroundColor(.white)
                                    .frame(width: 100, height: 150)
                                    .background(.green)
                            }
                        }
                    }
                    
                    Text("New Releases")
                        .font(.title2)
                        .multilineTextAlignment(.leading)
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(0..<10) {
                                Text("Item \($0)")
                                    .foregroundColor(.white)
                                    .frame(width: 100, height: 150)
                                    .background(.red)
                            }
                        }
                    }
                    
                    Text("Most Recent")
                        .font(.title2)
                        .multilineTextAlignment(.leading)
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(0..<10) {
                                Text("Item \($0)")
                                    .foregroundColor(.white)
                                    .frame(width: 100, height: 150)
                                    .background(.yellow)
                            }
                        }
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            Spacer()
        }
    }
}

struct SearchBar: View {
    @Binding var searchString: String
    var body: some View {
        HStack {
                Image(systemName: "magnifyingglass").foregroundColor(.gray)
                TextField("Search", text: $searchString)
                    .font(Font.system(size: 21))
            }
            .padding(7)
            .background(Color(.systemGray6))
            .cornerRadius(50)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}
