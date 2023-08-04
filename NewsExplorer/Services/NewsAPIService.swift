//
//  NewsAPIService.swift
//  NewsExplorer
//
//  Created by Dmytro Besedin on 04.08.2023.
//

import SwiftUI

final class NewsAPIService: ObservableObject {
    // MARK: - Constants
    static let shared = NewsAPIService()
    
    // MARK: - Private properties
    private let session = URLSession.shared
    
    // MARK: - Methods
    func fetchArticles(completion: @escaping (Result<[Article], Error>) -> Void)  {
        let urlString = RequestPathConstants.baseURL + RequestPathConstants.techCrunchArticle + RequestPathConstants.apiKey
        guard let url = URL(string: urlString) else {
            completion(.failure(NewsAPIError.invalidURL()))
            return
        }
        
        let dataTask = session.dataTask(with: url) { (data, urlResponse, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else { return }
            let jsonDecoder = JSONDecoder()
            do {
                let decodeData = try jsonDecoder.decode(NewsAPI.self, from: data)
                completion(.success(decodeData.articles))
            }
            catch (let error){
                completion(.failure(error))
            }
        }
        dataTask.resume()
    }
    
    func fetch(articleImageURL: String, completion: @escaping (Result<Image, Error>) -> Void) {
        guard let url = URL(string: articleImageURL) else {
            completion(.failure(NewsAPIError.invalidURL()))
            return
        }
        
        let dataTask = session.dataTask(with: url) { (data, urlResponse, error) in
            guard let data = data else {
                completion(.failure(NewsAPIError.invalidResponseData()))
                return
            }
            
            guard let uiImage = UIImage(data: data) else {
                completion(.failure(NewsAPIError.invalidImage()))
                return
            }
            
            completion(.success(Image(uiImage: uiImage)))
        }
        dataTask.resume()
    }
}
