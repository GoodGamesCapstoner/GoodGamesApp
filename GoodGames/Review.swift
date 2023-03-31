//
//  Review.swift
//  GoodGames
//
//  Created by Jackson Secrist on 3/13/23.
//

import Foundation
import FirebaseFirestoreSwift

struct Review: Codable, Identifiable, Equatable {
    @DocumentID var id: String?
    let appid: Int
    let creationDate: Date
    let hoursPlayed: Int
    let inApp: Bool
    let rating: Int
    let ratingBool: Int
    let text: String
    let userid: String
    let username: String
    
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: self.creationDate)
    }
    
    var recommended: Bool {
        return ratingBool == 1
    }
    
    var recommendedText: String {
        return recommended ? "Recommended" : "Not Recommended"
    }
    var recommendedImage: String {
        return recommended ? "hand.thumbsup.fill" : "hand.thumbsdown.fill"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case appid
        case creationDate = "creationDate"
        case hoursPlayed = "hoursPlayed"
        case inApp, rating, ratingBool
        case text = "review"
        case userid, username
    }
    
    //Conform to Equatable
    public static func ==(lhs: Review, rhs: Review) -> Bool {
        return lhs.id == rhs.id
    }
}
