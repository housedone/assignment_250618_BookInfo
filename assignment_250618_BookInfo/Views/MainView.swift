//
//  MainView.swift
//  assignment_250618_BookInfo
//
//  Created by 김우성 on 6/20/25.
//

import UIKit
import SnapKit

class MainView: UIView {
    
    private var books: [Book] = []
    private var selectedBookVolumeNumber: Int = 0
    private let headerView = HeaderView()
    //private let contentView = ContentView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        
        // delegate 알아보기
        
        addSubview(headerView)
        //addSubview(contentView)
        
        setupHeaderAndContentsConstraints()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// [Book] 입력을 받아 헤더 뷰와 컨텐츠 뷰를 구성
    func configureView(books: [Book]) {
        self.books = books
        headerView.configureView(books, selectedBookVolumeNumber)
        //contentView.configureView(books[selectedBookVolumeNumber], selectedBookVolumeNumber)
    }
    
    /// 헤더 뷰와 컨텐츠 뷰의 제약 설정
    private func setupHeaderAndContentsConstraints() {
        headerView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(10) // 나중에 다시 볼 필요 있음
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(20)
        }
        
//        contentView.snp.makeConstraints {
//            $0.top.equalTo(headerView.snp.bottom).offset(10)
//            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(20)
//        }
    }
    
    
    
    
}
