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
        scrollView.showsVerticalScrollIndicator = false // 스크롤 바 안보이게
        scrollView.addSubview(contentStackView)
        addSubview(scrollView)
        contentStackView.axis = .vertical
        contentStackView.spacing = 24
    }
    
    /// 제약 설정
    private func setupConstraints() {
        scrollView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.width.equalToSuperview() // 이거 없으면 스크롤이 좌우로 된다!
        }
        
        contentStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview() // 이거 없으면 위아래 스크롤도 안된다
            $0.width.equalToSuperview()
        }
    }
    
    func configureView(_ book: Book, _ bookVolumeNumber: Int) {
        // 갱신하며 기존 서브뷰 제거
        contentStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        let contentStack: [UIView] = [
            createBookBasicInfoStack(book, bookVolumeNumber),
            createDedicationStack("Dedication", book.dedication),
            createSummaryStack("Summary", book.summary, bookVolumeNumber),
            createChapterStack("Chapter", book.chapters)
        ]
        
        contentStack.forEach {
            contentStackView.addArrangedSubview($0)
        }
    }
    
    /// 책 기본 정보 뷰 구성 밎 제약 설정
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
        
        // (책 제목 + 저자 + 출간일 + 페이지수) 수직 스택 뷰
        let textStackView = UIStackView(arrangedSubviews: [
            bookTitleLabel,
            createInfoRow("Author", book.author),
            createInfoRow("Released", dateFormatterHelper(book.releaseDate)),
            createInfoRow("Pages", "\(book.pages)"),
        ])
        textStackView.axis = .vertical
        textStackView.spacing = 8
        textStackView.alignment = .leading
        
        // 책 기본 정보 - 표지 + (텍스트 정보 수직 스택 뷰) 수평 스택 뷰
        let bookInfoStackView = UIStackView(arrangedSubviews: [bookCoverImageView, textStackView])
        bookInfoStackView.axis = .horizontal
        bookInfoStackView.spacing = 16
        bookInfoStackView.alignment = .top
        
        return bookInfoStackView
    }
    
    /// 기본정보 뷰의 텍스트 타이틀과 값 속성 설정
    private func createInfoRow(_ title: String, _ value: String) -> UIStackView {
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
    
    /// Dedication 버티컬 스택 뷰 속성 설정
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
    
    /// Summary 버티컬 스택 뷰 속성 설정
    private func createSummaryStack(_ title: String, _ value: String, _ bookVolumeNumber: Int) -> UIStackView {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.textColor = .black
        
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = .systemFont(ofSize: 14)
        valueLabel.textColor = .darkGray
        valueLabel.numberOfLines = 0
        
        let seeMoreButton = UIButton()
        seeMoreButton.titleLabel?.font = .systemFont(ofSize: 14)
        seeMoreButton.setTitleColor(.systemBlue, for: .normal)
        seeMoreButton.contentHorizontalAlignment = .trailing
        
        // 펼쳐졌는지 아닌지에 대한 상태는 UserDefaults에 저장한다
        let isExpandedKey = "isExpanded_\(bookVolumeNumber)"
        var isExpanded = UserDefaults.standard.bool(forKey: isExpandedKey)
        
        func updateSummary() {
            if value.count >= 450 {
                valueLabel.text = isExpanded ? value : String(value.prefix(450)) + "..."
                seeMoreButton.setTitle(isExpanded ? "접기" : "더 보기", for: .normal)
                seeMoreButton.isHidden = false
            } else {
                valueLabel.text = value
                seeMoreButton.isHidden = true
            }
        }
        
        updateSummary()
        
        // seeMoreButton은 "더 보기"일 때는 눌렀을 때 valueLabel.text가 전체가 출력되어야 하고, 자기 자신의 텍스트는 "접기" 로 바꿈
        // "접기"일 때는 눌렀을 때 valueLabel.text의 앞 450글자만 출력되고, 뒤에 ... 이 붙어야 한다. 자기 자신의 텍스트는 "더 보기" 로 바뀌어야 한다.
        // 이 상태는 앱을 종료했다가 다시 실행했더라도 유지되어야 한다. 즉, 데이터를 저장해둬야 한다. -> UserDefaults
        
        seeMoreButton.addAction(UIAction { _ in
                isExpanded.toggle()
            UserDefaults.standard.set(isExpanded, forKey: isExpandedKey)
            updateSummary()
        }, for: .touchUpInside)
        
        let summaryStack = UIStackView(arrangedSubviews: [titleLabel, valueLabel, seeMoreButton])
        summaryStack.axis = .vertical
        summaryStack.spacing = 8
        
        return summaryStack
        
    }
    
    /// Chapters 버티컬 스택 뷰 속성 설정
    private func createChapterStack(_ title: String, _ value: [Chapter]) -> UIStackView {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.textColor = .black
        
        let chapterLabels: [UILabel] = value.map { chapter -> UILabel in
            let label = UILabel()
            label.text = chapter.title
            label.font = .systemFont(ofSize: 14)
            label.textColor = .darkGray
            label.numberOfLines = 0
            return label
        }
        
        let chapterStack = UIStackView(arrangedSubviews: [titleLabel] + chapterLabels)
        chapterStack.axis = .vertical
        chapterStack.spacing = 8
        
        return chapterStack
    }
}
