//
//  RequestPathConstants.swift
//  NewsExplorer
//
//  Created by Dmytro Besedin on 04.08.2023.
//

import Foundation

class RequestPathConstants {
    static let baseURL = "https://newsapi.org/v2/everything?"
    static let techCrunchDomain = "domains=techcrunch.com"
    static let apiKey = "&apiKey=58c544cc327c415b88d8cb4fda7749a2"
    static func getStringURL(from: String, to: String) -> String {
        return baseURL + RequestPathConstants.techCrunchDomain + "&from=\(from)&to=\(to)" + apiKey
    }
}
