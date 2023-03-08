//
//  LaunchScreen.swift
//  GoodGames
//
//  Created by Jackson Secrist on 3/7/23.
//

import SwiftUI

struct LaunchScreen: View {
    @EnvironmentObject var userVM: UserViewModel
    @EnvironmentObject var gameVM: GameViewModel
    
    var body: some View {
        LoadingController()
    }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen()
            .environmentObject(UserViewModel())
            .environmentObject(GameViewModel())
    }
}
