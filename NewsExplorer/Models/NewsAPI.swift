//
//  NewsAPI.swift
//  NewsExplorer
//
//  Created by Dmytro Besedin on 04.08.2023.
//

import Foundation

// MARK: - NewsAPI
struct NewsAPI: Codable {
    var status: String
    var totalResults: Int
    var articles: [Article]
}

// MARK: - Article
struct Article: Codable, Identifiable {
    var id = UUID()
    var source: Source
    var author: String
    var title, description: String
    var url: String
    var urlToImage: String
    var publishedAt: String
    var content: String
    
    enum CodingKeys: String, CodingKey {
        case source
        case author
        case title
        case description
        case url
        case urlToImage
        case publishedAt
        case content
    }
}

// MARK: - Hashable
extension Article: Hashable {
    static func == (lhs: Article, rhs: Article) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - Source
struct Source: Codable {
    let id: String
    let name: String
}

