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
    private let contentStackView = UIStackView() // 스크롤뷰 바로 안쪽 스택뷰
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        scrollView.showsVerticalScrollIndicator = false // 스크롤 바 안보이게
        scrollView.addSubview(contentStackView)
        
        addSubview(scrollView)
        contentStackView.axis = .vertical
        contentStackView.spacing = 24
        
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        contentStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.width.equalToSuperview() // 이거 없으면 스크롤이 좌우로 된다!
        }
    }
    
    func configureView(_ book: Book, _ bookVolumeNumber: Int) {
        contentStackView.arrangedSubviews.forEach { $0.removeFromSuperview() } // 갱신하며 기존 서브뷰 제거
        
        let contentStack: [UIView] = [
            createBookBasicInfoStack(book, bookVolumeNumber),
            createDedicationStack("Dedication", book.dedication),
            
            
            
            // Summary 버티컬 스택 뷰
            // Chapters 버티컬 스택 뷰
            
        ]
        
        contentStack.forEach {
            contentStackView.addArrangedSubview($0)
        }
    }
    
    // 책 정보 호라이즌탈 스택 뷰 - 이미지, (책 제목, 저자, 발매일, 페이지수)
    private func createBookBasicInfoStack(_ book: Book, _ bookVolumeNumber: Int) -> UIStackView {
        // 책 표지 구성
        let bookCoverImageView = UIImageView()
        bookCoverImageView.image = UIImage(named: "harrypotter\(bookVolumeNumber + 1)")
        bookCoverImageView.contentMode = .scaleAspectFit
        bookCoverImageView.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(bookCoverImageView.snp.width).multipliedBy(1.5)
        }
        
        // 책 제목 구성
        let bookTitleLabel = UILabel()
        bookTitleLabel.text = book.title
        bookTitleLabel.textColor = .black
        bookTitleLabel.font = .boldSystemFont(ofSize: 20)
        bookTitleLabel.numberOfLines = 0
        
        // 책 제목 + 저자 + 출간일 + 페이지수
        let textStackView = UIStackView(arrangedSubviews: [
            bookTitleLabel,
            createInfoRow("Author", book.author),
            createInfoRow("Released", dateFormatterHelper(book.releaseDate)),
            createInfoRow("Pages", "\(book.pages)")
        ])
        textStackView.axis = .vertical
        textStackView.spacing = 8
        textStackView.alignment = .leading
        
        // 책 기본 정보 - 표지 +
        let bookInfoStackView = UIStackView(arrangedSubviews: [bookCoverImageView, textStackView])
        bookInfoStackView.axis = .horizontal
        bookInfoStackView.spacing = 16
        bookInfoStackView.alignment = .top
        
        return bookInfoStackView
    }
    
    private func createInfoRow(_ title: String, _ value: String) -> UIStackView {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .boldSystemFont(ofSize: title == "Author" ? 16 : 14)
        titleLabel.textColor = .black
        //titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
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
    
    // Dedication 버티컬 스택 뷰
    private func createDedicationStack(_ title: String, _ value: String) -> UIStackView {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.textColor = .black
        
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = .systemFont(ofSize: 14)
        valueLabel.textColor = .darkGray
        valueLabel.numberOfLines = 0
        
        let dedicationStack = UIStackView(arrangedSubviews: [titleLabel, valueLabel])
        dedicationStack.axis = .vertical
        dedicationStack.spacing = 8
        return dedicationStack
    }
    
}
