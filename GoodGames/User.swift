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
    let email: String
    let username: String
    let firstName: String
    let lastName: String
    let usernameSearchList: [String]
    
    
    //MARK: - Initializers
    
    init(uid: String, email: String, username: String, firstName: String, lastName: String) {
        self.uid = uid
        self.email = email
        self.username = username
        self.firstName = firstName
        self.lastName = lastName
        self.usernameSearchList = username.searchified()
    }
    
    init(uid: String, email: String, username: String, firstName: String, lastName: String, searchList: [String]) {
        self.uid = uid
        self.email = email
        self.username = username
        self.firstName = firstName
        self.lastName = lastName
        self.usernameSearchList = searchList
    }
    
    //Conform to Equatable
    public static func ==(lhs: User, rhs: User) -> Bool {
        return lhs.uid == rhs.uid
    }
}
