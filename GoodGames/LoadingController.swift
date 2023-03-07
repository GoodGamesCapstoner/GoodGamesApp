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
        isLoading ? 50 : 5
    }
    
    var color: Color {
        isLoading ? .purple : .gray
    }
    
    var body: some View {
        VStack{
            Text("Top")
            Image(systemName: "gamecontroller.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: size)
                .foregroundColor(color)
                .animation(.easeInOut(duration: 2).repeatForever(), value: isLoading)
                .onAppear {
                    self.isLoading = true
                }
            Text("Bottom")
        }
    }
}

struct LoadingController_Previews: PreviewProvider {
    static var previews: some View {
        LoadingController()
    }
}
