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
    
    init(sheetIsPresented: Binding<Bool>) {
        self._sheetIsPresented = sheetIsPresented
        UITableView.appearance().backgroundColor = .green // Uses UIColor
    }
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack {
                    List(GameGenre.allCases, id: \.self) { genre in
                        NavigationLink(
                            genre.rawValue,
                            destination:
                                FilterGamesView(genre: [genre.rawValue])
                        )
                        .listRowBackground(Color.secondaryBackground)
                    }
                    .scrollContentBackground(.hidden)
                }
                .navigationBarTitle("Genres")
                .background(Color.primaryBackground)
            }
        }

    }
}


struct SetFilterView_Previews: PreviewProvider {
    static var previews: some View {
        SetFilterSheet(sheetIsPresented: .constant(true))
            .environmentObject(GameViewModel())
            .environmentObject(UserViewModel())
            .environment(\.colorScheme, .dark)
    }
}
