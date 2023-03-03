//
//  Color+HexCode.swift
//  GoodGames
//
//  Created by Matt Goulding on 3/3/23.
//

import Foundation
import SwiftUI

extension Color {
    init(hex: String) {
        var rgbValue: UInt64 = 0

        Scanner(string: hex).scanHexInt64(&rgbValue)

        let r = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let g = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let b = Double(rgbValue & 0x0000FF) / 255.0

        self.init(red: r, green: g, blue: b)
    }
}
