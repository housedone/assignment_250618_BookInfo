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

class HeaderView: UIView {
    
    weak var delegate: HeaderViewDelegate?
    
    private let topTitleLabel = UILabel()
    private let seriesButtonStackView = UIStackView()
    
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
    
    /// 제약 설정
    private func setupConstraints() {
        topTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview() // 헤더 뷰 탑 제약이 10이 이미 있으므로
            $0.leading.trailing.equalToSuperview()
        }
        
        seriesButtonStackView.snp.makeConstraints {
            $0.top.equalTo(topTitleLabel.snp.bottom).offset(16)
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
    }
    
    /// 책 리스트와 책 권차를 받아와 뷰 구성
    /// (스위프트의 배열은 COW: Copy On Write이기 때문에 책 한 권만 넘기는 식으로 구현할 필요는 없다)
    func configureView(_ books: [Book], _ bookVolumeNumber: Int) {
        topTitleLabel.text = books[bookVolumeNumber].title
        
        // 갱신하며 기존 서브뷰 제거
        seriesButtonStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for index in 0..<books.count {
            let seriesButton = UIButton()
            seriesButton.setTitle("\(index + 1)", for: .normal)
            seriesButton.titleLabel?.font = .systemFont(ofSize: 16)
            seriesButton.setTitleColor(index == bookVolumeNumber ? .white : .systemBlue, for: .normal)
            seriesButton.backgroundColor = index == bookVolumeNumber ? .systemBlue : .systemGray6
            seriesButton.tag = index
            seriesButton.layer.cornerRadius = 20
            seriesButton.addTarget(self, action: #selector(seriesButtonTapped), for: .touchUpInside)
            
            seriesButton.snp.makeConstraints {
                $0.width.height.equalTo(40)
            }
            
            seriesButtonStackView.addArrangedSubview(seriesButton)
        }
    }
    
    @objc
    func seriesButtonTapped(_ sender: UIButton) {
        delegate?.didTapSeriesButton(bookVolumeNumber: sender.tag)
    }
    
}
