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
    let aboutTheGame: String
    let appid: Int
    let categories, detailedDescription, developer: String
    let dlc: Bool
    let genre: String
    let headerImage: String
    let languages, name, platform, priceAdj: String
    let publisher: String
    let releaseDate: Date
    let reviewScore: Int
    let shortDescription, tags: String
    let totalReviews: Int

    enum CodingKeys: String, CodingKey {
        case aboutTheGame = "about_the_game"
        case appid, categories
        case detailedDescription = "detailed_description"
        case developer, dlc, genre
        case headerImage = "header_image"
        case languages, name, platform
        case priceAdj = "price_adj"
        case publisher
        case releaseDate = "release_date"
        case reviewScore = "review_score"
        case shortDescription = "short_description"
        case tags
        case totalReviews = "total_reviews"
    }
}
