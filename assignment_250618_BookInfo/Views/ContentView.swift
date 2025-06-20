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
        addSubview(scrollView)
        scrollView.showsVerticalScrollIndicator = false // 스크롤 바 안보이게
        scrollView.addSubview(contentStackView)
        
        contentStackView.axis = .vertical
        contentStackView.spacing = 8
        
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview() // 이게 .edges인가? 나중에 확인
        }
        
        contentStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalToSuperview()
        }
    }
    
    func configureView(_ book: Book, _ selectedBookVolumeNumber: Int) {
        contentStackView.arrangedSubviews.forEach { $0.removeFromSuperview() } // 갱신하며 기존 서브뷰 제거
        
        let contentStack: [UIView] = [
            // 책 정보 호라이즌탈 스택 뷰 - 이미지, (책 제목, 저자, 발매일, 페이지수)
            // Dedication 버티컬 스택 뷰
            // Summary 버티컬 스택 뷰
            // Chapters 버티컬 스택 뷰
            
        ]
        
        contentStack.forEach {
            contentStackView.addArrangedSubview($0)
        }
    }
}
