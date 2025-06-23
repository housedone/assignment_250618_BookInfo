//
//  ContentView.swift
//  assignment_250618_BookInfo
//
//  Created by 김우성 on 6/20/25.
//

import UIKit
import SnapKit

/// 컨텐츠 뷰
final class ContentView: UIView {
    
    // MARK: - UI Components
    private let scrollView = UIScrollView()
    private let contentStackView = UIStackView()
    
    // MARK: - Subviews
    private let bookInfoView = BookBasicInfoView() // 책 기본정보
    private let dedicationView = DedicationView() // 헌정사
    private let summaryView = SummaryView() // 요약
    private let chapterListView = ChapterListView() // 목차
    
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
        backgroundColor = .white
        
        addSubview(scrollView)
        scrollView.addSubview(contentStackView)
        scrollView.showsVerticalScrollIndicator = false
        
        contentStackView.axis = .vertical
        contentStackView.spacing = 24
        
        // 스택뷰에 하위 뷰 순서대로 미리 배치
        contentStackView.addArrangedSubview(bookInfoView)
        contentStackView.addArrangedSubview(dedicationView)
        contentStackView.addArrangedSubview(summaryView)
        contentStackView.addArrangedSubview(chapterListView)
    }
    
    // MARK: - Constraints
    private func setupConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        contentStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
    }
    
    // MARK: - Configuration
    func configureView(book: Book, bookVolumeNumber: Int) {
        bookInfoView.configure(book: book, bookVolumeNumber: bookVolumeNumber)
        dedicationView.configure(title: "Dedication", value: book.dedication)
        summaryView.configure(title: "Summary", value: book.summary, bookVolumeNumber: bookVolumeNumber)
        chapterListView.configure(title: "Chapters", chapters: book.chapters)
    }
}
