//
//  PCDateFormatter.swift
//  PathChallenge
//
//  Created by Mehmet Kerse on 11.07.2021.
//

import Foundation


class PCDateFormatter {
    static func formatFilter(date: Date) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-dd-MM"
        return dateFormatterGet.string(from: date)
    }
}
