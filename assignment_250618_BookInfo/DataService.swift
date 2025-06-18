//
//  DataService.swift
//  assignment_250618_BookInfo
//
//  Created by 김우성 on 6/18/25.
//

import Foundation

struct BookResponse: Codable {
    let data: [BookData]
}

struct BookData: Codable {
    let attributes: Book
}

struct Chapter: Codable {
    var title: String
}

struct Book: Codable {
    var title: String
    var author: String
    var pages: Int
    var release_date: String
    var dedication: String
    var summary: String
    var wiki: String
    var chapters: [Chapter]
}

class DataService {
    
    enum DataError: Error {
        case fileNotFound
        case parsingFailed
    }
    
    /// 책을 불러오는 함수.
    /// completion : 클로저 파라미터. 결과가 준비되었을 때 호출된다.
    /// @escaping : 이 클로저는 함수가 끝난 뒤에도 호출될 수 있기 때문에 escape 가능성을 명시한다.
    /// 성공하면 [Book] / 실패하면 Error 타입을 리턴한다.
    func loadBooks(completion: @escaping (Result<[Book], Error>) -> Void) {
        
        /// 앱의 번들에서 data.json이라는 파일을 찾는다.
        /// guard let : 파일 경로가 없으면 fileNotFound라는 DataError 호출. 찾았으면 넘어감
        guard let path = Bundle.main.path(forResource: "data", ofType: "json") else {
            completion(.failure(DataError.fileNotFound))
            return
        }
        
        /// 파일 경로를 URL로 변환해서 해당 파일의 내용을 Data 타입으로 읽어온다. 를 try
        /// JSONDecoder()를 사용해 JSON 데이터를 BookResponse로 디코딩한다. BookResponse는 Codable 또는 최소 Decodable을 채택한 타입이어야 한다.
        /// a
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let bookResponse = try JSONDecoder().decode(BookResponse.self, from: data)
            let books = bookResponse.data.map { $0.attributes }
            completion(.success(books))
        } catch {
            print("🚨 JSON 파싱 에러 : \(error)")
            completion(.failure(DataError.parsingFailed))
        }
    }
    
    private let dataService = DataService()

    func loadBooks() {
        dataService.loadBooks { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let books):
                for book in books {
                    
                }
                
            case .failure(let error):
                print("🚨 에러 : \(error)")
            }
        }
    }
}



