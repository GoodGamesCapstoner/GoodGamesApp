//
//  ColorPalette.swift
//  GoodGames
//
//  Created by Adriana Cottle on 3/10/23.
//

import SwiftUI

extension Color {
    //accent colors
    static let accentSet = "A1"
    static let accentDarkIsPrimary = false
    static let primaryAccent = Color("\(accentSet)-\(accentDarkIsPrimary ? "Dark":"Light")")
    static let secondaryAccent = Color("\(accentSet)-\(accentDarkIsPrimary ? "Light":"Dark")")
    
    //background colors
    static let backgroundSet = "B3"
    static let backgroundDarkIsPrimary = true
    static let primaryBackground = Color("\(backgroundSet)-\(backgroundDarkIsPrimary ? "Dark":"Light")")
    static let secondaryBackground = Color("\(backgroundSet)-\(backgroundDarkIsPrimary ? "Light":"Dark")")
}
