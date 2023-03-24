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
    
    @State var showModelFailedAlert: Bool = false
    var body: some View {
        if gameVM.modelReadyState != .ready {
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
                    .alert("Failed to connect", isPresented: $showModelFailedAlert) {
                        Button("Retry", role: .cancel) {
                            gameVM.initializeAppData(with: user)
                        }
                    } message: {
                        Text("App data failed to load, please try again later")
                    }
                } else {
                    VStack(spacing: 30){
                        Spacer()
                        Text("Loading your awesome user data...")
                            .fontDesign(.monospaced)
                            .foregroundColor(.white)
                    }
                }
            }
            .onChange(of: gameVM.modelReadyState) { newValue in
                if newValue == .failed {
                    showModelFailedAlert = true
                }
            }
            
        } else {
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
