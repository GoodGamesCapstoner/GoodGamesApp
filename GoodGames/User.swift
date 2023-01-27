//
//  User.swift
//  GoodGames
//
//  Created by Jackson Secrist on 1/26/23.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Codable, Identifiable {
    @DocumentID var id: String?
    var firstName: String
    var lastName: String
    var username: String
}
