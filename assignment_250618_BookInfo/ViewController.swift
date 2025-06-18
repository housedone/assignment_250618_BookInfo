//
//  ViewController.swift
//  assignment_250618_BookInfo
//
//  Created by 김우성 on 6/18/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        configureUI()
    }
    
    private var bookList: [Book] = []
    
    private let dataService = DataService()
    
    func loadBooks() {
        dataService.loadBooks { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let books):
                bookList = books
                print("책 정보 불러왔음")
            case .failure(let error):
                print("🚨 에러 : \(error)")
            }
        }
    }
    
    // 기본적으로 0번째 항목의 내용을 출력. 6번째까지 있음 (+= 1 하자)
    // 버튼을 누르면 출력되는 내용이 달라져야 함
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        
        loadBooks()
        
        guard !bookList.isEmpty else {
            return
        }
        
        // 제목 라벨 설정
        var titleLabel = UILabel()
        titleLabel.text = bookList[0].title
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        
        // 시리즈 순서 버튼 설정
        var numberButton = UIButton()
        numberButton.setTitle("1", for: .normal)
        numberButton.setTitleColor(.white, for: .normal)
        numberButton.titleLabel?.font = .systemFont(ofSize: 16)
        numberButton.backgroundColor = .systemBlue
        numberButton.layer.cornerRadius = 20
        
        
        // 책 표지 이미지 속성
        var bookCoverImageView = UIImageView()
        bookCoverImageView.image = UIImage(named: "harrypotter1.jpg")
        bookCoverImageView.contentMode = .scaleAspectFit // 바꿔보기
        bookCoverImageView.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(150)
        }
        
        // 책 제목 속성
        let bookTitleLabel = UILabel()
        bookTitleLabel.text = bookList[0].title
        bookTitleLabel.textColor = .black
        bookTitleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        bookTitleLabel.textAlignment = .center
        bookTitleLabel.numberOfLines = 2
        
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
        
        // 이 세 Row들 간의 간격은? StackView가 알아서 맞춰줌
        let authorRow = createInfoRow(titleLabel: titleLabelMaker(text: "Author", fontSize: 16), valueLabel: valueLabelMaker(text: bookList[0].author, textColor: .darkGray, fontSize: 18))
        let releaseDateRow = createInfoRow(titleLabel: titleLabelMaker(text: "Released", fontSize: 14), valueLabel: valueLabelMaker(text: dateFormatterHelper(bookList[0].release_date), textColor: .gray, fontSize: 16))
        let pagesRow = createInfoRow(titleLabel: titleLabelMaker(text: "Pages", fontSize: 14), valueLabel: valueLabelMaker(text: "\(bookList[0].pages)", textColor: .gray, fontSize: 14))
        
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
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(300)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
        }
        
        numberButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(40)
        }
        
        bookInfoStackView.snp.makeConstraints {
            $0.top.equalTo(numberButton.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    
    }
}
