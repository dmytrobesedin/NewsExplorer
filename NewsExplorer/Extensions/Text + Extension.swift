//
//  Text + Extension.swift
//  NewsExplorer
//
//  Created by Dmytro Besedin on 08.08.2023.
//

import SwiftUI

extension Text {
    func higlighted() -> Text {
        self
            .underline(pattern: .solid)
            .foregroundColor(.yellow)
    }
}
