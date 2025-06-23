//
//  DataService.swift
//  assignment_250618_BookInfo
//
//  Created by 김우성 on 6/18/25.
//

import Foundation

class DataService {
    
    /// 책을 불러오는 함수.
    /// 성공하면 [Book], 실패하면 Error 타입 리턴
    func loadBooks(completion: @escaping (Result<[Book], Error>) -> Void) {
        // completion : 클로저 파라미터. 결과가 준비되었을 때 호출된다.
        // @escaping : 이 클로저는 함수가 끝난 뒤에도 호출될 수 있기 때문에 escape 가능성을 명시한다.
        
        // 앱의 번들에서 data.json이라는 파일을 찾는다.
        guard let path = Bundle.main.path(forResource: "data", ofType: "json") else {
            completion(.failure(DataError.fileNotFound))
            return
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))                // 파일 경로를 URL로 변환해서 해당 파일의 내용을 Data 타입으로 읽어온다.
            let bookResponse = try JSONDecoder().decode(BookResponse.self, from: data) // JSONDecoder()를 사용해 JSON 데이터를 BookResponse로 디코딩한다.
            let books = bookResponse.data.map { $0.attributes }
            completion(.success(books))
        } catch {
            print("🚨 JSON 파싱 에러 : \(error)")
            completion(.failure(DataError.parsingFailed))
        }
    }
}
