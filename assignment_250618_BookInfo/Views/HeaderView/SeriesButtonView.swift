//
//  SeriesButtonView.swift
//  assignment_250618_BookInfo
//
//  Created by 김우성 on 6/23/25.
//

import UIKit
import SnapKit

final class SeriesButtonView: UIButton {
    
    // MARK: - Delegate
    weak var delegate: HeaderViewDelegate?
    
    // MARK: - Properties
    private var index: Int = 0
    
    // MARK: - Initializer
    init(index: Int, isSelected: Bool) {
        super.init(frame: .zero)
        self.index = index
        setupView(isSelected: isSelected)
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupView(isSelected: Bool) {
        setTitle("\(index + 1)", for: .normal)
        titleLabel?.font = .systemFont(ofSize: 16)
        setTitleColor(isSelected ? .white : .systemBlue, for: .normal)
        backgroundColor = isSelected ? .systemBlue : .systemGray6
        layer.cornerRadius = 20
        snp.makeConstraints { $0.width.height.equalTo(40) }
    }
    
    // MARK: - 시리즈 버튼
    @objc private func buttonTapped() {
        delegate?.didTapSeriesButton(bookVolumeNumber: index)
    }
}
