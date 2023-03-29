//
//  String+Searchify.swift
//  GoodGames
//
//  Created by Jackson Secrist on 3/27/23.
//

import Foundation


extension String {
    func searchified() -> [String] {
        var searchKeywords: [String] = []
        let splitArr = self.split(separator: " ")
                
        var keyword = ""
        var prevLetter = ""
        
        for index in splitArr.indices {
            let substring = splitArr[index...].joined(separator: " ")
            for letter in substring {
                keyword = prevLetter + String(letter)
                prevLetter = keyword
                searchKeywords.append(keyword)
            }
            keyword = ""
            prevLetter = ""
        }
        
        return searchKeywords
    }
}
