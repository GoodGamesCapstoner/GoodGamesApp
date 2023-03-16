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
        if !gameVM.viewModelReady {
            ZStack {
                LaunchGraphic()
                
                if userVM.isUserAuthenticated == .signedIn, let user = userVM.user {
                    VStack(spacing: 30){
                        Spacer()
                        Text("Loading magnificent game data...")
                            .fontDesign(.monospaced)
                            .foregroundColor(.white)
                    }
                    .onAppear {
                        gameVM.initializeAppData(with: user)
                    }
                } else {
                    VStack(spacing: 30){
                        Spacer()
                        Text("Loading your awesome user data...")
                            .fontDesign(.monospaced)
                            .foregroundColor(.white)
                    }
                    .onAppear {
                        
                    }
                }
            }
            
        }
        else {
            MainTabView()
        }
        
    }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen()
            .environmentObject(UserViewModel())
            .environmentObject(GameViewModel())
    }
}
