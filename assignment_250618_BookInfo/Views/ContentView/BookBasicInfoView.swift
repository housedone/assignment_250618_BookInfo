//
//  BookBasicInfoView.swift
//  assignment_250618_BookInfo
//
//  Created by 김우성 on 6/23/25.
//

import UIKit
import SnapKit

class BookBasicInfoView: UIStackView {
    
    // 책 기본 정보 - 표지 + (텍스트 정보 수직 스택 뷰) 수평 스택 뷰
    init(book: Book, bookVolumeNumber: Int) {
        super.init(frame: .zero)
        axis = .horizontal
        spacing = 16
        alignment = .top
        
        // 책 표지 구성
        let bookCoverImageView = UIImageView()
        bookCoverImageView.image = UIImage(named: "harrypotter\(bookVolumeNumber + 1)")
        bookCoverImageView.contentMode = .scaleAspectFit
        bookCoverImageView.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(bookCoverImageView.snp.width).multipliedBy(1.5)
        }
        
        // (책 제목 + 저자 + 출간일 + 페이지수) 수직 스택 뷰
        let textStackView = UIStackView(arrangedSubviews: [
            createBookTitleLabel(value: book.title),
            createInfoStack(title: "Author", value: book.author),
            createInfoStack(title: "Released", value: dateFormatterHelper(book.releaseDate)),
            createInfoStack(title: "Pages", value: "\(book.pages)"),
        ])
        textStackView.axis = .vertical
        textStackView.spacing = 8
        textStackView.alignment = .leading
        
        addArrangedSubview(bookCoverImageView)
        addArrangedSubview(textStackView)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 책 제목 구성
    private func createBookTitleLabel(value: String) -> UILabel {
        let bookTitleLabel = UILabel()
        bookTitleLabel.text = value
        bookTitleLabel.textColor = .black
        bookTitleLabel.font = .boldSystemFont(ofSize: 20)
        bookTitleLabel.numberOfLines = 0
        
        return bookTitleLabel
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
