//
//  Book.swift
//  assignment_250618_BookInfo
//
//  Created by 김우성 on 6/18/25.
//

import Foundation

struct BookResponse: Codable {
    let data: [BookData]
}

struct BookData: Codable {
    let attributes: Book
}

struct Book: Codable {
    var title: String
    var author: String
    var pages: Int
    var releaseDate: String
    var dedication: String
    var summary: String
    var wiki: String
    var chapters: [Chapter]
    
    enum CodingKeys: String, CodingKey {
        case title, author, pages, dedication, summary, wiki, chapters
        case releaseDate = "release_date"
    }
}

struct Chapter: Codable {
    var title: String
}
