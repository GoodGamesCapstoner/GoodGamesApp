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
    let dlc: Bool
    let date: Date
    let platform, priceAdj, aboutTheGame: String
    let appid: Int
    let categories, detailedDescription, developer, genre: String
    let headerImage: String
    let languages, nameX, publisher: String
    let reviewScore: Int
    let shortDescription, tags: String
    let totalReviews: Int

    enum CodingKeys: String, CodingKey {
        case dlc = "DLC"
        case date = "Date"
        case platform = "Platform"
        case priceAdj = "Price_Adj"
        case aboutTheGame = "about_the_game"
        case appid, categories
        case detailedDescription = "detailed_description"
        case developer, genre
        case headerImage = "header_image"
        case languages
        case nameX = "name_x"
        case publisher
        case reviewScore = "review_score"
        case shortDescription = "short_description"
        case tags
        case totalReviews = "total_reviews"
    }
}
