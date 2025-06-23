//
//  DataError.swift
//  assignment_250618_BookInfo
//
//  Created by 김우성 on 6/20/25.
//

import Foundation

enum DataError: Error, LocalizedError {
    case fileNotFound
    case parsingFailed
    
    var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return "🚨 데이터 파일을 찾을 수 없습니다."
        case .parsingFailed:
            return "🚨 데이터를 불러오는 데에 실패했습니다."
        }
    }
}
