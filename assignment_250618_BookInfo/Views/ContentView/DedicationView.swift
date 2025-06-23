//
//  DedicationView.swift
//  assignment_250618_BookInfo
//
//  Created by 김우성 on 6/23/25.
//

import UIKit
import SnapKit

/// Dedication 버티컬 스택 뷰
class DedicationView: UIStackView {
    
    init(title: String, value: String) {
        super.init(frame: .zero)
        axis = .vertical
        spacing = 8
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.textColor = .black
        
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = .systemFont(ofSize: 14)
        valueLabel.textColor = .darkGray
        valueLabel.numberOfLines = 0
        
        addArrangedSubview(titleLabel)
        addArrangedSubview(valueLabel)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
