//
//  NewsAPIError.swift
//  NewsExplorer
//
//  Created by Dmytro Besedin on 04.08.2023.
//

import Foundation

enum NewsAPIError: Error {
    case invalidURL(description: String = "Invalid URL.")
    case invalidImage(description: String = "Invalid Image.")
    case invalidResponseData(description: String = "Invalid response data.")
}
