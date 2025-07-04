//
//  SummaryView.swift
//  assignment_250618_BookInfo
//
//  Created by 김우성 on 6/23/25.
//

import UIKit
import SnapKit

/// 요약 뷰
final class SummaryView: UIStackView {
    
    // MARK: - Properties
    private let titleLabel = UILabel()
    private let valueLabel = UILabel()
    private let seeMoreButton = UIButton()
    
    private var fullText: String = ""
    private var isExpandedKey: String = ""
    
    private var isExpanded: Bool {
        get { UserDefaults.standard.bool(forKey: isExpandedKey) }
        set { UserDefaults.standard.set(newValue, forKey: isExpandedKey) }
    }
    
    // MARK: - Initializer
    init() {
        super.init(frame: .zero)
        setupView()
        setupActions()
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
        
        seeMoreButton.titleLabel?.font = .systemFont(ofSize: 14)
        seeMoreButton.setTitleColor(.systemBlue, for: .normal)
        seeMoreButton.contentHorizontalAlignment = .trailing
        
        addArrangedSubview(titleLabel)
        addArrangedSubview(valueLabel)
        addArrangedSubview(seeMoreButton)
    }
    
    private func setupActions() {
        seeMoreButton.addAction(UIAction { [weak self] _ in
            guard let self = self else { return }
            self.isExpanded.toggle()
            self.updateSummary()
        }, for: .touchUpInside)
    }
    
    // MARK: - Configuration
    func configure(title: String, value: String, bookVolumeNumber: Int) {
        self.fullText = value
        self.isExpandedKey = "isExpanded_\(bookVolumeNumber)"
        
        titleLabel.text = title
        updateSummary()
    }
    
    // MARK: - 더보기 버튼
    private func updateSummary() {
        if fullText.count >= 450 {
            valueLabel.text = isExpanded ? fullText : String(fullText.prefix(450)) + "..."
            seeMoreButton.setTitle(isExpanded ? "접기" : "더 보기", for: .normal)
            seeMoreButton.isHidden = false
        } else {
            valueLabel.text = fullText
            seeMoreButton.isHidden = true
        }
    }
}
