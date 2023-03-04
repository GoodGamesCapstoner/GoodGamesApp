//
//  TestView.swift
//  GoodGames
//
//  Created by Jackson Secrist on 3/1/23.
//

import SwiftUI

struct TestView: View {
    @EnvironmentObject var gameVM: GameViewModel
    
    var body: some View {
        Text("Test View")
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView().environmentObject(GameViewModel())
    }
}
