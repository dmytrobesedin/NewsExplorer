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
    static let apiKey = "&apiKey=b028e072018d448c856442309d8c9cf2"
    static func getStringURL(from: String, to: String) -> String {
        return baseURL + RequestPathConstants.techCrunchDomain + "&from=\(from)&to=\(to)" + apiKey
    }
}
