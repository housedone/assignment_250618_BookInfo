//
//  DateFormatterHelper.swift
//  assignment_250618_BookInfo
//
//  Created by 김우성 on 6/18/25.
//

import Foundation

func dateFormatterHelper(_ release_date: String) -> String {
    let inputFormatter = DateFormatter()
    inputFormatter.locale = Locale(identifier: "en_US_POSIX") // 영어 월 표기를 위해 추천됨
    inputFormatter.dateFormat = "yyyy-MM-dd"
    
    if let releaseDate = inputFormatter.date(from: release_date) {
        let outputFormatter = DateFormatter()
        outputFormatter.locale = Locale(identifier: "en_US_POSIX")
        outputFormatter.dateFormat = "MMM d, yyyy"
        let formattedDateString = outputFormatter.string(from: releaseDate)
        
        return formattedDateString
    } else {
        return "날짜 파싱 안됐어 이놈아"
    }
}
