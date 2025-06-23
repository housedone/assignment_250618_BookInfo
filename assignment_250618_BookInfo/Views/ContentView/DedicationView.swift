//
//  DedicationView.swift
//  assignment_250618_BookInfo
//
//  Created by 김우성 on 6/23/25.
//

import UIKit
import SnapKit

/// 헌정사 뷰
final class DedicationView: UIStackView {
    
    // MARK: - Properties
    private let titleLabel = UILabel()
    private let valueLabel = UILabel()
    
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
        
        valueLabel.font = .systemFont(ofSize: 14)
        valueLabel.textColor = .darkGray
        valueLabel.numberOfLines = 0
        
        addArrangedSubview(titleLabel)
        addArrangedSubview(valueLabel)
    }
    
    // MARK: - Configuration
    func configure(title: String, value: String) {
        titleLabel.text = title
        valueLabel.text = value
    }
}
