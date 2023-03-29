//
//  SetFilterView.swift
//  GoodGames
//
//  Created by Adriana Cottle on 3/24/23.
//

import SwiftUI

enum FilterType {
    case genres, categories
    
//    var tabImageName: String {
//        switch self {
//        case .genres:
//            return "tag.fill"
//        case .categories:
//            return "tag.fill"
//        }
//    }
    
    var tabDisplayText: String {
        switch self {
        case .genres:
            return "Genres"
        case .categories:
            return "Categories"
        }
    }
}

struct SetFilterSheet: View {
    @EnvironmentObject var gameVM: GameViewModel
    @EnvironmentObject var userVM: UserViewModel
    
    @Binding var sheetIsPresented: Bool
    
    @State private var selectedFilter: FilterType = .genres
    
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
                    HStack(spacing: 0) {
                        FilterTab(selectedTab: $selectedFilter, type: .genres, width: geometry.size.width/2.0)
                        FilterTab(selectedTab: $selectedFilter, type: .categories, width: geometry.size.width/2.0)
                    }
                    if selectedFilter == .genres {
                        List(GameGenre.allCases, id: \.self) { genre in
                            NavigationLink(
                                genre.rawValue,
                                destination:
                                    FilterGamesView(genre: [genre.rawValue])
                            )
                            .listRowBackground(Color.secondaryBackground)
                        }
                        .scrollContentBackground(.hidden)
                    } else {
                        List(GameCategory.allCases, id: \.self) { category in
                            NavigationLink(
                                category.rawValue,
                                destination:
                                    FilterGamesView(genre: [category.rawValue])
                            )
                            .listRowBackground(Color.secondaryBackground)
                        }
                        .scrollContentBackground(.hidden)
                    }
                }
                .background(Color.primaryBackground)
            }
        }

    }
}

struct FilterTab: View {
    @Binding var selectedTab: FilterType
    var type: FilterType
    var width: CGFloat
    
    var selected: Bool {
        return selectedTab == type
    }
    
    var body: some View {
        Button {
            selectedTab = type
        } label: {
            VStack(spacing: 0) {
                HStack {
//                    Image(systemName: type.tabImageName)
//                        .foregroundColor(.white)
                    
                    Text(type.tabDisplayText)
                        .font(Font.system(size: 18, weight: .semibold))
                        .foregroundColor(Color.white)
                }
                .frame(width: width, height: 40)
                Rectangle().fill(selected ? Color.white : Color.clear)
                    .frame(height: 3)
            }
            .fixedSize()
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
