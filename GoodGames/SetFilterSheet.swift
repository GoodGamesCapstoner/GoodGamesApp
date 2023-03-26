//
//  SetFilterView.swift
//  GoodGames
//
//  Created by Adriana Cottle on 3/24/23.
//

import SwiftUI

struct SetFilterSheet: View {
    @EnvironmentObject var gameVM: GameViewModel
    @EnvironmentObject var userVM: UserViewModel
    
    @Binding var sheetIsPresented: Bool
    
    @State var showTextError = false
    @State var selectedGenre: String = ""
    
    var animatedOpacity1: Double {
        showTextError ? 1.0 : 0
    }
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack {
                    NavigationStack {
                        Form {
                            Section() {
                                List(GameGenre.allCases, id: \.self) { genre in
                                    NavigationLink(
                                        genre.rawValue,
                                        destination:
                                            FilterGamesView(genre: [genre.rawValue])
                                        // selection: $selectedGenre
                                    )
                                    .navigationBarTitle("Genres")
                                }
                            }
                        }
                    }
                    .padding()
                }
                .background(Color.primaryBackground) // neither is this
            }
        }
        .background(Color.primaryBackground) // this isn't doing anything

    }
}

//
//struct SetFilterView_Previews: PreviewProvider {
//    static var previews: some View {
//        SetFilterView(gameVM: .constant(true), userVM: 123, appid: 123)
//            .environmentObject(GameViewModel())
//            .environmentObject(UserViewModel())
//            .environment(\.colorScheme, .dark)
//    }
//}
