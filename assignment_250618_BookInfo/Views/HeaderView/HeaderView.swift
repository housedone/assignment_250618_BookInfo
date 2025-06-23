//
//  HeaderView.swift
//  assignment_250618_BookInfo
//
//  Created by 김우성 on 6/20/25.
//

import UIKit
import SnapKit

protocol HeaderViewDelegate: AnyObject {
    func didTapSeriesButton(bookVolumeNumber: Int)
}

/// 헤더 뷰
final class HeaderView: UIView {
    
    // MARK: - Delegate
    weak var delegate: HeaderViewDelegate?
    
    // MARK: - UI Components
    private let topTitleLabel = UILabel() // 최상단 제목
    private let seriesButtonStackView = UIStackView() // 시리즈 버튼
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupViews() {
        addSubview(topTitleLabel)
        addSubview(seriesButtonStackView)
        
        topTitleLabel.font = .boldSystemFont(ofSize: 24)
        topTitleLabel.textAlignment = .center
        topTitleLabel.numberOfLines = 0
        
        seriesButtonStackView.axis = .horizontal
        seriesButtonStackView.spacing = 8
        seriesButtonStackView.alignment = .center
        seriesButtonStackView.distribution = .equalSpacing
    }
    
    private func setupConstraints() {
        topTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        
        seriesButtonStackView.snp.makeConstraints {
            $0.top.equalTo(topTitleLabel.snp.bottom).offset(16)
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Configuration
    func configureView(books: [Book], bookVolumeNumber: Int) {
        topTitleLabel.text = books[bookVolumeNumber].title
        seriesButtonStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for index in 0..<books.count {
            let button = SeriesButtonView(index: index, isSelected: index == bookVolumeNumber)
            button.delegate = delegate
            seriesButtonStackView.addArrangedSubview(button)
        }
    }
}
