//
//  Review.swift
//  GoodGames
//
//  Created by Jackson Secrist on 3/13/23.
//

import Foundation
import FirebaseFirestoreSwift

struct Review: Codable, Identifiable {
    @DocumentID var id: String?
    let appid: Int
    let creationDate: Date
    let hoursPlayed: Int
    let rating: Int
    let text: String
    let userid: String
    let username: String
    
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: self.creationDate)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case appid
        case creationDate = "creation_date"
        case hoursPlayed = "hours_played"
        case rating
        case text = "review_text"
        case userid, username
    }
}
