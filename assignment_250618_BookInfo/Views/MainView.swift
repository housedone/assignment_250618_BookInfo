//
//  MainView.swift
//  assignment_250618_BookInfo
//
//  Created by 김우성 on 6/20/25.
//

import UIKit
import SnapKit

/// 메인 뷰
final class MainView: UIView {
    
    // MARK: - Properties
    private var books: [Book] = []
    private var selectedBookVolumeNumber: Int = 0
    
    // MARK: - Subviews
    private let headerView = HeaderView() // 헤더 뷰 - 최상단 제목, 시리즈 버튼
    private let contentView = ContentView() // 컨텐츠 뷰 - 책 기본정보, 헌정사, 요약, 목차
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupView() {
        backgroundColor = .systemBackground
        
        headerView.delegate = self
        
        addSubview(headerView)
        addSubview(contentView)
    }
    
    private func setupConstraints() {
        headerView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(10)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(20)
        }
        
        contentView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(20)
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Configuration
    func configureView(books: [Book]) {
        self.books = books
        updateViews()
    }
    
    private func updateViews() {
        headerView.configureView(books: books, bookVolumeNumber: selectedBookVolumeNumber)
        contentView.configureView(book: books[selectedBookVolumeNumber], bookVolumeNumber: selectedBookVolumeNumber)
    }
}

// MARK: - HeaderViewDelegate
extension MainView: HeaderViewDelegate { // 델리게이트 이벤트 핸들링
    func didTapSeriesButton(bookVolumeNumber: Int) {
        selectedBookVolumeNumber = bookVolumeNumber
        updateViews()
    }
}
