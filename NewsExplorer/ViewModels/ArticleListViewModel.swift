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
    @Published var sortedParam: SortedParam = .title
    @Published var isDescriptionSorted: Bool = false
    @Published var isDateTimeViewShown: Bool = false
    @Published var fromDate: Date = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        guard let date = formatter.date(from: "2023/08/03") else {
            return Date.now
        }
        return date
    }()
    @Published var toDate = Date.now
    @Published var query = ""
    
    // MARK: - Private properties
    @ObservedObject private(set) var newsAPIService = NewsAPIService.shared
    
    // MARK: - Methods
    func getArticles() async {
        state = .loading
        
        newsAPIService.fetchArticles(from: fromDate, to: toDate) { result in
            switch result {
            case .success(let articles):
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.articles = articles
                    self.articles = self.sortArticlesForParam(self.sortedParam)
                    let hasArticles = self.articles.isEmpty == false
                    self.state = hasArticles ? .content : .empty
                }
            case .failure(let error):
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.showAlert(title: Constants.receiveArticlesTitle,
                                   message: error.localizedDescription)
                    self.state = .empty
                }
                
            }
        }
    }
    
    func sortArticlesForParam(_ param: SortedParam) -> [Article] {
        switch param {
        case .title:
            return articles.sorted {
                $0.title < $1.title
            }
        case .description:
            return articles.sorted {
                $0.description < $1.description
            }
        }
    }
    
    func sortButtonAction() {
        if isDescriptionSorted {
            sortedParam = .title
        } else {
            sortedParam = .description
        }
        isDescriptionSorted.toggle()
    }
    
    // MARK: - Private methods
    private func showAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showAlert = true
    }
}
