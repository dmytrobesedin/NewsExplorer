//
//  ArticleViewModel.swift
//  NewsExplorer
//
//  Created by Dmytro Besedin on 05.08.2023.
//

import SwiftUI

final class ArticleViewModel: ObservableObject {
    // MARK: - Constants
    let progressSize: CGFloat = 44
    let imageWidth: CGFloat = 70
    let imageHeight: CGFloat = 100
    
    // MARK: - Properties
    var article: Article
    @Published var query: String = ""
    @Published var isLoading = false
    @Published var articleImage = Image(systemName: Constants.questionMarkSquare)
    @Published var showAlert = false
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    @ObservedObject private var newsAPIService = NewsAPIService.shared
    
    // MARK: - Init
    init(article: Article) {
        self.article = article
    }
    
    // MARK: - Methods
    func fetchArticleImage() {
        isLoading = true
        newsAPIService.fetch(articleImageURL: article.urlToImage) { result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.articleImage = success
                    self.isLoading = false
                }
            case .failure(let failure):
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.isLoading = false
                    self.showAlert(title: "Fetch article Image", message: failure.localizedDescription)
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
