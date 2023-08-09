//
//  String + Extension.swift
//  NewsExplorer
//
//  Created by Dmytro Besedin on 09.08.2023.
//

import Foundation

extension String {
    var convertUTCToDate: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .autoupdatingCurrent
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = dateFormatter.date(from: self) else {
            return nil
        }
        dateFormatter.dateFormat = "MM-dd-yyyy"
        return dateFormatter.string(from: date)
    }
}
