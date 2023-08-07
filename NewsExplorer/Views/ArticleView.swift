//
//  ArticleView.swift
//  NewsExplorer
//
//  Created by Dmytro Besedin on 04.08.2023.
//

import SwiftUI

struct ArticleView: View {
    // MARK: - Properties
    @StateObject var viewModel: ArticleViewModel
    
    // MARK: - Init
    init(article: Article) {
        self._viewModel = StateObject(wrappedValue: ArticleViewModel(article: article))
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 5) {
            if viewModel.isLoading {
                ProgressView()
                    .frame(width: viewModel.progressSize,
                           height: viewModel.progressSize,
                           alignment: .center)
                    .padding()
                    .overlay(
                        Circle()
                            .strokeBorder(Color.white,
                                          lineWidth: 4)
                    )
            } else {
                viewModel.articleImage
                    .resizable()
                    .frame(width: viewModel.imageWidth,
                           height: viewModel.imageHeight,
                           alignment: .center)
            }
            
            bookInfoView
            
        }
        .onAppear {
            viewModel.fetchArticleImage()
        }
        .alert(isPresented: $viewModel.showAlert, content: {
            Alert(
                title: Text(viewModel.alertTitle),
                message: Text(viewModel.alertMessage),
                dismissButton: .default(Text("OK"))
            )
        })
        .searchable(text: $viewModel.query, prompt: Constants.searchPrompt)
        .padding(.vertical)
        .padding(.horizontal, 20)
        .frame(width: UIScreen.main.bounds.width - 24)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.25)))
    }
    
    private var bookInfoView: some View {
        VStack(alignment: .leading, spacing: 5) {
            HighlightedTextView(viewModel.article.title, matching: viewModel.query)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.black)
            
            VStack(alignment: .leading, spacing: 5) {
                HighlightedTextView("\(Article.CodingKeys.author.rawValue) - \(viewModel.article.author)", matching: viewModel.query)
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.black)
                
                Text("\(Article.CodingKeys.publishedAt.rawValue) - \(viewModel.article.publishedAt)")
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.black)
                
                HighlightedTextView("\(Article.CodingKeys.source.rawValue) - \(viewModel.article.source.name)", matching: viewModel.query)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.black)
            }
            
            HighlightedTextView("\(Article.CodingKeys.description.rawValue) - \(viewModel.article.description)", matching: viewModel.query)
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
        }
    }
}

struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleView(article: Article(source: .init(id: "", name: ""),
                                     author: "",
                                     title: "",
                                     description: "",
                                     url: "",
                                     urlToImage: "",
                                     publishedAt: "",
                                     content: ""))
    }
}
