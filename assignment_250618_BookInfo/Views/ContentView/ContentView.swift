//
//  ContentView.swift
//  assignment_250618_BookInfo
//
//  Created by 김우성 on 6/20/25.
//

import UIKit
import SnapKit

class ContentView: UIView {
    
    private let scrollView = UIScrollView() // 맨 바깥 스크롤뷰
    private let contentStackView = UIStackView() // 스크롤뷰 내부 스택뷰
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 서브 뷰로 추가하며 속성 설정
    private func setupViews() {
        scrollView.showsVerticalScrollIndicator = false
        scrollView.addSubview(contentStackView)
        addSubview(scrollView)
        contentStackView.axis = .vertical
        contentStackView.spacing = 24
    }
    
    /// 제약 설정
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
    
    func configureView(_ book: Book, _ bookVolumeNumber: Int) {
        contentStackView.arrangedSubviews.forEach { $0.removeFromSuperview() } // 갱신하며 기존 서브뷰 제거
        
        contentStackView.addArrangedSubview(BookBasicInfoView(book: book, bookVolumeNumber: bookVolumeNumber))
        contentStackView.addArrangedSubview(DedicationView(title: "Dedication", value: book.dedication))
        contentStackView.addArrangedSubview(SummaryView(title: "Summary", value: book.summary, bookVolumeNumber: bookVolumeNumber))
        contentStackView.addArrangedSubview(ChapterListView(title: "Chapter", value: book.chapters))
        
    }
}
