//
//  ChapterListView.swift
//  assignment_250618_BookInfo
//
//  Created by 김우성 on 6/23/25.
//

import UIKit
import SnapKit

/// 목차 뷰
final class ChapterListView: UIStackView {
    
    // MARK: - Properties
    private let titleLabel = UILabel()
    private var chapterLabels: [UILabel] = []
    
    // MARK: - Initializer
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupView() {
        axis = .vertical
        spacing = 8
        
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.textColor = .black
        
        addArrangedSubview(titleLabel)
    }
    
    // MARK: - Configuration
    func configure(title: String, chapters: [Chapter]) {
        // 타이틀 설정
        titleLabel.text = title
        
        // 기존 chapterLabels 제거
        chapterLabels.forEach { $0.removeFromSuperview() }
        chapterLabels.removeAll()
        
        // 새로운 chapterLabels 생성 및 추가
        let labels = chapters.map { chapter -> UILabel in
            let label = UILabel()
            label.text = chapter.title
            label.font = .systemFont(ofSize: 14)
            label.textColor = .darkGray
            label.numberOfLines = 0
            return label
        }
        
        labels.forEach { addArrangedSubview($0) }
        chapterLabels = labels
    }
}
