//
//  ViewController.swift
//  assignment_250618_BookInfo
//
//  Created by 김우성 on 6/18/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private var titleLabel = UILabel()
    private var numberButton = UIButton()
    private var bookList: [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        configureUI()
    }
    
    // 기본적으로 0번째 항목의 내용을 출력. 6번째까지 있음 (+= 1 하자)
    // 버튼을 누르면 출력되는 내용이 달라져야 함
    
    private func configureUI() {
        loadBooks()
        
        view.backgroundColor = .systemBackground
        
        titleLabel.text = bookList[1 - 1].title
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        
        numberButton.setTitle("1", for: .normal)
        numberButton.setTitleColor(.white, for: .normal)
        numberButton.titleLabel?.font = .systemFont(ofSize: 16)
        numberButton.backgroundColor = .systemBlue
        numberButton.layer.cornerRadius = 20
        
        
        
        [titleLabel, numberButton]
            .forEach {
                view.addSubview($0)
            }
        
        // leading, trailing = superView로부터 20
        // top = safeArea로부터 10
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
    }
    
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
}



