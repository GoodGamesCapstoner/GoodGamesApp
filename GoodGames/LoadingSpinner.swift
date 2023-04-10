//
//  LoadingSpinner.swift
//  GoodGames
//
//  Created by Jackson Secrist on 3/6/23.
//

import SwiftUI

struct LoadingSpinner: View {
    @State private var isLoading = false
    private var progress: CGFloat {
        isLoading ? 1 : 0.0005
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.secondaryBackground, lineWidth: 5)
                .frame(width: 100, height: 100)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(Color.primaryAccent, lineWidth: 5)
                .frame(width: 100, height: 100)
                .rotationEffect(Angle(degrees: 270))
                .onAppear() {
                    DispatchQueue.main.async {
                        withAnimation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: false)) {
                            self.isLoading = true
                        }
                    }
                }
        }
    }
}

struct LoadingSpinner_Previews: PreviewProvider {
    static var previews: some View {
        LoadingSpinner()
    }
}
