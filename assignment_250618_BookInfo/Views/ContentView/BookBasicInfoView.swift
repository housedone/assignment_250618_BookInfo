//
//  BookBasicInfoView.swift
//  assignment_250618_BookInfo
//
//  Created by 김우성 on 6/23/25.
//

import UIKit
import SnapKit

/// 책 기본정보
final class BookBasicInfoView: UIStackView {
    
    // MARK: - UI Components
    private let bookCoverImageView = UIImageView() // 책 표지
    private let textStackView = UIStackView() // (책 제목 + 저자 + 출간일 + 페이지수) 수직 스택 뷰
    
    // MARK: - Initializers
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupView() {
        axis = .horizontal
        spacing = 16
        alignment = .top
        
        bookCoverImageView.contentMode = .scaleAspectFit
        bookCoverImageView.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(bookCoverImageView.snp.width).multipliedBy(1.5)
        }
        
        textStackView.axis = .vertical
        textStackView.spacing = 8
        textStackView.alignment = .leading
        
        addArrangedSubview(bookCoverImageView)
        addArrangedSubview(textStackView)
    }
    
    // MARK: - Configuration
    func configure(book: Book, bookVolumeNumber: Int) {
        // 이미지 설정
        bookCoverImageView.image = UIImage(named: "harrypotter\(bookVolumeNumber + 1)")
        
        // 기존 subviews 제거 후 재구성
        textStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        textStackView.addArrangedSubview(createBookTitleLabel(value: book.title))
        textStackView.addArrangedSubview(createInfoStack(title: "Author", value: book.author))
        textStackView.addArrangedSubview(createInfoStack(title: "Released", value: dateFormatterHelper(book.releaseDate)))
        textStackView.addArrangedSubview(createInfoStack(title: "Pages", value: "\(book.pages)"))
    }
    
    // MARK: - Subviews
    private func createBookTitleLabel(value: String) -> UILabel {
        let label = UILabel()
        label.text = value
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }
    
    private func createInfoStack(title: String, value: String) -> UIStackView {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .boldSystemFont(ofSize: title == "Author" ? 16 : 14)
        titleLabel.textColor = .black
        
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = .systemFont(ofSize: title == "Author" ? 18 : 14)
        valueLabel.textColor = title == "Author" ? .darkGray : .gray
        
        let hStack = UIStackView(arrangedSubviews: [titleLabel, valueLabel])
        hStack.axis = .horizontal
        hStack.spacing = 8
        hStack.alignment = .leading
        
        return hStack
    }
}
