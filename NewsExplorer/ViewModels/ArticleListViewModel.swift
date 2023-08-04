//
//  ArticleListViewModel.swift
//  NewsExplorer
//
//  Created by Dmytro Besedin on 04.08.2023.
//

import SwiftUI

final class ArticleListViewModel: ObservableObject {
    @Published var articles = [Article]()
    @Published var showAlert = false
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    @Published var state: LoadingState = .empty
    
    // MARK: - Private properties
    @ObservedObject private(set) var newsAPIService = NewsAPIService.shared
    
    // MARK: - Methods
    func getArticles() async {
        state = .loading
        
        newsAPIService.fetchArticles { result in
            switch result {
            case .success(let articles):
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.articles = articles
                    let hasArticles = self.articles.isEmpty == false
                    self.state = hasArticles ? .content : .empty
                }
            case .failure(let error):
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.showAlert(title: "Receive articles",
                                   message: error.localizedDescription)
                    self.state = .empty
                }
                
            }
        }
    }
    
    private func showAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showAlert = true
    }
}
