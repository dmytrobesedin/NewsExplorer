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
        NavigationView {
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
            .navigationBarTitle(Constants.techCrunchTitle)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: sortButton, trailing: searchButton)
            .onAppear {
                getArticles()
            }
            .onChange(of: viewModel.isDateTimeViewShown) { newValue in
                if !newValue {
                    getArticles()
                }
            }
            .sheet(isPresented: $viewModel.isDateTimeViewShown, content: {
                ChooseTimePeriodView(isShowDateTimeView: $viewModel.isDateTimeViewShown,
                                     fromDate: $viewModel.fromDate,
                                     toDate: $viewModel.toDate)
                .presentationDetents([.fraction(0.35)])
            })
            .alert(isPresented: $viewModel.showAlert, content: {
                Alert(
                    title: Text(viewModel.alertTitle),
                    message: Text(viewModel.alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            })
        }
    }
    
    // MARK: - Private properties
    private var articles: some View {
        ScrollView {
            ForEach(viewModel.sortedArticlesForParam(viewModel.sortedParam)) { article in
                NavigationLink {
                    ArticleView(article: article)
                } label: {
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(article.title)
                                .lineLimit(3)
                                .multilineTextAlignment(.leading)
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.black)
                            
                            Text(article.description)
                                .multilineTextAlignment(.leading)
                                .fixedSize(horizontal: false, vertical: true)
                                .lineSpacing(3)
                                .lineLimit(5)
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(.black)
                        }
                        
                        Spacer()
                        
                        Image(systemName: Constants.arrowRight)
                    }
                    .padding(.all, 10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.25)))
                }
            }
        }
        .padding(.top, 10)
        .padding(.horizontal, 10)
        .refreshable {
            getArticles()
        }
    }
    
    private var sortButton: some View {
        Button(action: {
            viewModel.sortButtonAction()
        }, label: {
            Text(viewModel.isDescriptionSorted ? SortedParam.description.rawValue : SortedParam.title.rawValue)
        })
    }
    
    private var searchButton: some View {
        Button(action: {
            viewModel.isDateTimeViewShown.toggle()
        }, label: {
            Image(systemName: Constants.magnifyingglass)
        })
    }
    
    // MARK: - Private methods
    private func getArticles() {
        Task {
            await viewModel.getArticles()
        }
    }
}

struct ArticleListView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleListView()
    }
}
