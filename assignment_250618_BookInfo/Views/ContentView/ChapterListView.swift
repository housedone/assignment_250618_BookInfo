//
//  ChapterListView.swift
//  assignment_250618_BookInfo
//
//  Created by 김우성 on 6/23/25.
//

import UIKit
import SnapKit

class ChapterListView: UIStackView {
    
    init(title: String, value: [Chapter]) {
        super.init(frame: .zero)
        axis = .vertical
        spacing = 8
        
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
        
        addArrangedSubview(titleLabel)
        chapterLabels.forEach { addArrangedSubview($0) }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
