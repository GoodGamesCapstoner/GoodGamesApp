//
//  LaunchGraphic.swift
//  GoodGames
//
//  Created by Jackson Secrist on 3/9/23.
//

import SwiftUI

struct LaunchGraphic: View {
    @State var offset: CGFloat = AnimationConstants.defaultOffset
    @State var rotation: CGFloat = AnimationConstants.defaultRotation
    @State var mScale: CGFloat = AnimationConstants.defaultScale
    @State var spacing: CGFloat = 20.0
    @State var leftLetterLean: CGFloat = 0
    var rightLetterLean: CGFloat {
        leftLetterLean * -1
    }
    
    var body: some View {
        ZStack {
            Color.secondaryBackground
            
            VStack {
                HStack(spacing: 20.0) {
                    Text("G")
                    Text("O")
                    Text("O")
                    Text("D")
                }
                .font(.system(size: 60))
                    
                ZStack {
                    HStack(spacing: 20.0) {
                        Text("G")
                            .rotationEffect(Angle(degrees: leftLetterLean), anchor: .bottomLeading)
                        HStack(spacing: spacing){
                            Text("A")
                                .rotationEffect(Angle(degrees: leftLetterLean), anchor: .bottomLeading)
                            Text("M")
                                .scaleEffect(x: 1, y: mScale, anchor: .bottom)
                            Text("E")
                                .rotationEffect(Angle(degrees: rightLetterLean), anchor: .bottomTrailing)
                        }
                        Text("S")
                            .rotationEffect(Angle(degrees: rightLetterLean), anchor: .bottomTrailing)
                    }
                    Image(systemName: "gamecontroller.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .rotationEffect(Angle(degrees: rotation), anchor: .bottomLeading)
                        .offset(x: 0, y: offset)
                        .frame(width: 75.0)
                        .onAppear {
                            doAnimationRepeat()
                        }
                }
                .font(.system(size: 50))
            }
            .fontDesign(.monospaced)
            .fontWeight(.bold)
            .foregroundColor(.white)
        }.edgesIgnoringSafeArea(.vertical)
    }
    func doAnimationRepeat() {
        doAnimations()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
            doAnimationRepeat()
        }
    }
    
    func doAnimations() {
        resetAnimators()
        
        withAnimation(.easeIn(duration: 1.0)) { setOffset(to: 0.0) }     //initial fall
        
        withAnimation(.easeIn(duration: 0.10).delay(1.0)){ setMScale(to: 0.1) }      //m "squashed"
        
        withAnimation(.easeOut(duration: 0.5).delay(1.0)) {self.spacing = 60}
        withAnimation(.easeOut(duration: 0.5).delay(1.1)) {
            self.leftLetterLean = -40
        }
        withAnimation(.easeOut(duration: 0.25).delay(1.75)) {
            self.leftLetterLean = 0
        }
        
        withAnimation(.easeOut(duration: 0.25).delay(1.0)){ setOffset(to: -20.0) }    //bounce up
        
        withAnimation(.easeIn(duration: 0.20).delay(1.25)){ setOffset(to: 0.0) }      //bounce down
        
        withAnimation(.easeInOut(duration: 0.50).delay(2.0)){ setRotation(to: 150) }      //swing left
        
        withAnimation(.easeInOut(duration: 0.25).delay(2.5)){ setRotation(to: 110) }      //swing right
        
        withAnimation(.easeInOut(duration: 0.20).delay(2.75)){ setRotation(to: 140) }     //swing left
        
        withAnimation(.easeInOut(duration: 0.15).delay(2.95)){ setRotation(to: 120) }     //swing right
        
        withAnimation(.easeIn(duration: 1.0).delay(3)) { setOffset(to: 400.0) }       //fall off
        
        withAnimation(.easeOut(duration: 0.5).delay(4.0)) {self.spacing = 20.0}
        withAnimation(.easeInOut(duration: 0.5).delay(4)){ setMScale(to: 1.0) }       //m "revived"
    }
    
    func setOffset(to newOffset: CGFloat) {
        self.offset = newOffset
    }
    
    func setRotation(to newAngle: CGFloat) {
        self.rotation = newAngle
    }
    
    func setMScale(to scaleFactor: CGFloat) {
        self.mScale = scaleFactor
    }
    
    func resetAnimators() {
        setOffset(to: AnimationConstants.defaultOffset)
        setRotation(to: AnimationConstants.defaultRotation)
        setMScale(to: AnimationConstants.defaultScale)
    }
    
    struct AnimationConstants {
        static let defaultOffset: CGFloat = -525.0
        static let defaultRotation: CGFloat = 0.0
        static let defaultScale: CGFloat = 1.0
    }
}

struct LaunchGraphic_Previews: PreviewProvider {
    static var previews: some View {
        LaunchGraphic()
    }
}
