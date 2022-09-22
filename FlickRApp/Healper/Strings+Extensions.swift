//
//  Strings+Extensions.swift
//  FlickRApp
//
//  Created by Joshua on 21/09/2022.
//

import Foundation

extension String {
    func getStringToDate() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "MMMM d, yyyy"
        if let date = date {
            let formattedString = dateFormatter.string(from: date)
            return formattedString
        } else {
            return nil
        }
    }
}
