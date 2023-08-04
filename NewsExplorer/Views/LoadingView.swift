//
//  LoadingView.swift
//  NewsExplorer
//
//  Created by Dmytro Besedin on 04.08.2023.
//

import SwiftUI

struct LoadingView: View {
    // MARK: - Properties
    var body: some View {
        ZStack {
            VStack {
                Text("Loading..")
                
                ProgressView()
                    .scaleEffect(1.5)
                    .padding(.top, 25)
            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
