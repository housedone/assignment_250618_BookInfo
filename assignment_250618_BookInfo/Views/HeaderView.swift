//
//  HeaderView.swift
//  assignment_250618_BookInfo
//
//  Created by 김우성 on 6/20/25.
//

import UIKit
import SnapKit



class HeaderView: UIView {
    
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
            $0.top.equalToSuperview() // 헤더 뷰 탑 제약이 10이 이미 있으므로
            $0.leading.trailing.equalToSuperview()
        }
        
        seriesButtonStackView.snp.makeConstraints {
            $0.top.equalTo(topTitleLabel.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
    }
    
    func configureView(_ books: [Book], _ selectedBookVolumeNumber: Int) {
        topTitleLabel.text = books[selectedBookVolumeNumber].title
        
        seriesButtonStackView.arrangedSubviews.forEach { $0.removeFromSuperview() } // 갱신하며 기존 서브뷰 제거
        
        for index in 0..<books.count {
            let seriesButton = UIButton()
            seriesButton.setTitle("\(index + 1)", for: .normal)
            seriesButton.titleLabel?.font = .systemFont(ofSize: 16)
            seriesButton.setTitleColor(index == selectedBookVolumeNumber ? .white : .systemBlue, for: .normal)
            seriesButton.backgroundColor = index == selectedBookVolumeNumber ? .systemBlue : .systemGray6
            seriesButton.tag = index
            seriesButton.layer.cornerRadius = 20
            seriesButton.addTarget(self, action: #selector(seriesButtonTapped), for: .touchUpInside)
            
            seriesButton.snp.makeConstraints {
                $0.width.height.equalTo(40)
            }
            
            seriesButtonStackView.addArrangedSubview(seriesButton)
        }
    }
    
    @objc private func seriesButtonTapped(_ sender: UIButton) {
        //
    }
    
}
