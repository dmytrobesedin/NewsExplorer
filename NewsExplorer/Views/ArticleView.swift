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
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: - Init
    init(article: Article) {
        self._viewModel = StateObject(wrappedValue: ArticleViewModel(article: article))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                HighlightedTextView(viewModel.article.title, matching: viewModel.query)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
                
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
                        .aspectRatio(contentMode: .fit)
                        .frame(width: viewModel.imageWidth,
                               height: viewModel.imageHeight,
                               alignment: .center)
                }
                
                articleInfoView
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
        .onAppear {
            viewModel.fetchArticleImage()
        }
        .searchable(text: $viewModel.query,
                    placement: .navigationBarDrawer(displayMode: .always),
                    prompt: Constants.searchPrompt)
        .alert(isPresented: $viewModel.showAlert, content: {
            Alert(
                title: Text(viewModel.alertTitle),
                message: Text(viewModel.alertMessage),
                dismissButton: .default(Text("OK"))
            )
        })
        .padding(.vertical)
        .padding(.horizontal, 20)
        .frame(width: UIScreen.main.bounds.width - 24)
    }
    
    private var articleInfoView: some View {
        VStack(alignment: .leading, spacing: 5) {
            VStack(alignment: .leading, spacing: 5) {
                HStack(spacing: 5) {
                    Image(systemName: Constants.personCircle)
                    
                    HighlightedTextView(viewModel.article.author, matching: viewModel.query)
                        .fixedSize(horizontal: false, vertical: true)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(.black)
                    
                }
                
                HStack(spacing: 5) {
                    Image(systemName: Constants.calendarCircle)
                    
                    Text(viewModel.article.publishedAt.convertUTCToDate ?? "")
                        .fixedSize(horizontal: false, vertical: true)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(.black)
                    
                }
                
                HStack(spacing: 5) {
                    Image(systemName: Constants.globe)
                    
                    HighlightedTextView(viewModel.article.source.name, matching: viewModel.query)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(.black)
                }
            }
            
            HighlightedTextView(viewModel.article.description, matching: viewModel.query)
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
        }
    }
    
    private var backButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: Constants.chevronLeft)
        })
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
