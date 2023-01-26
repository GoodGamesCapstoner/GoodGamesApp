//
//  Game.swift
//  GoodGames
//
//  Created by Jackson Secrist on 1/24/23.
//

import Foundation
import FirebaseFirestoreSwift

struct Game: Codable, Identifiable {
    @DocumentID var id: String? 
    var name: String
    var release_date: Date
    var developer: String
    var publisher: String
    
//    init(name: String, releaseDate: String, developer: String, publisher: String) {
//        self.name = name
//        self.releaseDate = releaseDate
//        self.developer = developer
//        self.publisher = publisher
//    }
}
