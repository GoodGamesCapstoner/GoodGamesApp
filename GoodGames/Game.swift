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
    
    //MARK: - Computer Properties
    var cardImage: String {
        CardImage.url(for: self)
    }
    
    var formattedReleaseDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: self.releaseDate)
    }
    
    var formattedGenres: String {
        self.genre.replacingOccurrences(of: " ", with: ", ") //NEEDS WORK: replaces Early Access with Early, Access :/
    }
    
    var calculatedRating: CGFloat {
        CGFloat(reviewScore) / 2.0
    }
    var maxRating: CGFloat = 5.0

    enum CodingKeys: String, CodingKey {
        case id
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

private struct CardImage {
    static func url(for game: Game) -> String {
        return "https://steamcdn-a.akamaihd.net/steam/apps/\(game.appid)/library_600x900_2x.jpg"
    }
}
