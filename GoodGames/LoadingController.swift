//
//  LoadingController.swift
//  GoodGames
//
//  Created by Jackson Secrist on 3/6/23.
//

import SwiftUI

struct LoadingController: View {
    @State private var isLoading: Bool = false
    
    var size: CGFloat {
        isLoading ? 50 : 50
    }
    
    var rotation: CGFloat {
        isLoading ? 360 : 0
    }
    
    var color: Color {
        isLoading ? .purple : .purple
    }
    
    var body: some View {
        VStack{
//            Text("Top")
            Image(systemName: "gamecontroller.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100)
                .rotationEffect(Angle.degrees(rotation))
                .foregroundColor(color)
                .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: isLoading)
                .onAppear {
                    self.isLoading = true
                }
//            Text("Bottom")
        }
    }
}

struct LoadingController_Previews: PreviewProvider {
    static var previews: some View {
        LoadingController()
    }
}
