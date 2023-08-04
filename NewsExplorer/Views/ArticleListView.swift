//
//  ArticleListView.swift
//  NewsExplorer
//
//  Created by Dmytro Besedin on 04.08.2023.
//

import SwiftUI

struct ArticleListView: View {
    // MARK: - Properties
    @StateObject var viewModel = ArticleListViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                switch viewModel.state {
                case .loading:
                    LoadingView()
                        .navigationBarTitleDisplayMode(.inline)
                case .empty:
                    EmptyView()
                case .content:
                    articles
                }
            }
            .onAppear {
                Task {
                    await viewModel.getArticles()
                }
            }
            .navigationDestination(for: Article.self) { article in
                ArticleView(article: article)
            }
            .alert(isPresented: $viewModel.showAlert, content: {
                Alert(
                    title: Text(viewModel.alertTitle),
                    message: Text(viewModel.alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            })
        }
    }
    
    var articles: some View {
        ScrollView {
            ForEach(viewModel.articles) { article in
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(article.title)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.black)
                        
                        Text(article.description)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                            .lineSpacing(3)
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                    
                    NavigationLink(value: article, label: {
                        Image(systemName: Constants.arrowRight)
                            .buttonStyle(.borderless)
                    })
                }
                .padding(.all, 10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.25)))
            }
        }
        .padding(.horizontal, 10)
    }
}

struct ArticleListView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleListView()
    }
}
