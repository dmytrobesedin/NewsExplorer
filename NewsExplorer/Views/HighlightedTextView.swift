//
//  HighlightedTextView.swift
//  NewsExplorer
//
//  Created by Dmytro Besedin on 07.08.2023.
//

import SwiftUI

struct HighlightedTextView: View {
    let text: String
    let matching: String
    
    init(_ text: String, matching: String) {
        self.text = text
        self.matching = matching
    }
    
    var body: some View {
        let tagged = text.replacingOccurrences(of: self.matching, with: "<SPLIT>>\(self.matching)<SPLIT>")
        let split = tagged.components(separatedBy: "<SPLIT>")
        return split.reduce(Text("")) { (a, b) -> Text in
            guard !b.hasPrefix(">") else {
                return a + Text(b.dropFirst()).higlighted()
            }
            return a + Text(b)
        }
    }
}

struct HighlightedTextView_Previews: PreviewProvider {
    static var previews: some View {
        HighlightedTextView("", matching: "")
    }
}
