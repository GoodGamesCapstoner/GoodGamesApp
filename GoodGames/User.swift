//
//  User.swift
//  GoodGames
//
//  Created by Matt Goulding on 2/10/23.
//

import Foundation

/// The User object created when the user authenticates.
public struct User: Codable, Equatable {
    let uid: String
    let name: String
    let email: String
    
    //Conform to Equatable
    public static func ==(lhs: User, rhs: User) -> Bool {
        return lhs.uid == rhs.uid
    }
}

