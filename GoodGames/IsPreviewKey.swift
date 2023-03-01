//
//  IsPreviewKey.swift
//  GoodGames
//
//  Created by Jackson Secrist on 2/27/23.
//

import SwiftUI

private struct IsPreviewKey: EnvironmentKey {
    static let defaultValue = false
}

extension EnvironmentValues {
    var isPreview: Bool {
        get { self[IsPreviewKey.self] }
        set { self[IsPreviewKey.self] = newValue }
    }
}

