//
//  ViewController.swift
//  assignment_250618_BookInfo
//
//  Created by 김우성 on 6/18/25.
//

import UIKit
import SnapKit

final class ViewController: UIViewController {
    
    // MARK: - Properties
    private let dataService = DataService()
    private let mainView = MainView()
    private var books: [Book] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        loadBooks()
    }
    
    // MARK: - Setup
    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(mainView)
    }
    
    private func setupConstraints() {
        mainView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - 데이터 로딩
    private func loadBooks() {
        dataService.loadBooks { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let books):
                    print("책 정보 불러왔음")
                    self.books = books
                    self.mainView.configureView(books: books)
                case .failure(let error):
                    self.handleError(error)
                }
            }
        }
    }
    
    // MARK: - 에러 핸들링
    private func handleError(_ error: Error) {
        let alertController = UIAlertController(title: "데이터 로딩 실패", message: error.localizedDescription, preferredStyle: .alert)
        alertController.addAction(.init(title: "확인", style: .default))
        present(alertController, animated: true)
    }
}
