//
//  ViewController.swift
//  assignment_250618_BookInfo
//
//  Created by 김우성 on 6/18/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private let dataService = DataService()
    private let mainView = MainView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mainView)
        mainView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        loadBooks()
    }
    
    
    // MARK: - 데이터 로딩
    
    private func loadBooks() {
        dataService.loadBooks { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let books):
                print("책 정보 불러왔음")
                DispatchQueue.main.async { self.mainView.configureView(books: books) }
            case .failure(let error):
                self.handleError(error)
            }
        }
    }
    
    
    // MARK: - 에러 핸들링
    
    private func handleError(_ error: Error) {
        let message: String
        
        switch error {
        case DataError.fileNotFound:
            message = "🚨 데이터 파일을 찾을 수 없습니다."
        case DataError.parsingFailed:
            message = "🚨 데이터를 불러오는 데에 실패했습니다."
        default:
            message = error.localizedDescription
        }
        
        let alertController = UIAlertController(title: "데이터 로딩 실패", message: message, preferredStyle: .alert)
        alertController.addAction(.init(title: "확인", style: .default))
        present(alertController, animated: true)
    }
}











    
    /*
    
    
    private var currentIndex: Int = 0 // 책 권차
    
    
    
    // UI 컴포넌트들
    private var bookCoverImageView: UIImageView!
    private var bookTitleLabel: UILabel!
    

    
    
    
    // MARK: - UI 구성
    
    private func configureUI() {
        
        
        // 책 표지 구성
        bookCoverImageView = UIImageView()
        bookCoverImageView.image = UIImage(named: "harrypotter1.jpg")
        bookCoverImageView.contentMode = .scaleAspectFit // 바꿔보기
        bookCoverImageView.snp.makeConstraints {
            $0.top.equalTo(numberButton.snp.bottom).offset(20)
            $0.width.equalTo(100)
            $0.height.equalTo(150)
        }
        
        // 책 상세 정보 - 책 제목 구성
        bookTitleLabel = UILabel()
        bookTitleLabel.text = books[0].title
        bookTitleLabel.textColor = .black
        bookTitleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        bookTitleLabel.textAlignment = .center
        bookTitleLabel.numberOfLines = 2
        
        // 책 상세 정보
        let authorRow = createInfoRow(titleLabel: titleLabelMaker(text: "Author", fontSize: 16), valueLabel: valueLabelMaker(text: books[0].author, textColor: .darkGray, fontSize: 18))
        let releaseDateRow = createInfoRow(titleLabel: titleLabelMaker(text: "Released", fontSize: 14), valueLabel: valueLabelMaker(text: dateFormatterHelper(books[0].release_date), textColor: .gray, fontSize: 16))
        let pagesRow = createInfoRow(titleLabel: titleLabelMaker(text: "Pages", fontSize: 14), valueLabel: valueLabelMaker(text: "\(books[0].pages)", textColor: .gray, fontSize: 14))
        
        let textStackView = UIStackView(arrangedSubviews: [bookTitleLabel, authorRow, releaseDateRow, pagesRow])
        textStackView.axis = .vertical
        textStackView.spacing = 8
        textStackView.alignment = .leading
        
        let bookInfoStackView = UIStackView(arrangedSubviews: [bookCoverImageView, textStackView])
        bookInfoStackView.axis = .horizontal
        bookInfoStackView.spacing = 16
        bookInfoStackView.alignment = .top
        
        [titleLabel, numberButton, bookInfoStackView]
            .forEach {
                view.addSubview($0)
            }
        
        
        func createInfoRow(titleLabel: UILabel, valueLabel: UILabel) -> UIStackView {
            let hStack = UIStackView(arrangedSubviews: [titleLabel, valueLabel])
            hStack.axis = .horizontal
            hStack.spacing = 8
            hStack.alignment = .leading
            return hStack
        }
        
        func titleLabelMaker(text: String, fontSize: CGFloat) -> UILabel {
            let titleLabel = UILabel()
            titleLabel.text = text
            titleLabel.textColor = .black
            titleLabel.font = .systemFont(ofSize: fontSize, weight: .bold)
            return titleLabel
        }
        
        func valueLabelMaker(text: String, textColor: UIColor, fontSize: CGFloat) -> UILabel {
            let valueLabel = UILabel()
            valueLabel.text = text
            valueLabel.textColor = textColor
            valueLabel.font = .systemFont(ofSize: fontSize)
            return valueLabel
        }
        
        
        
        
    
    }
}
        */
