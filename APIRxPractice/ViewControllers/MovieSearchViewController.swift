//
//  ViewController.swift
//  APIRxPractice
//
//  Created by 황인호 on 11/6/23.
//

import UIKit
import RxSwift
import RxCocoa

final class MovieSearchViewController: UIViewController {
    
    private let searchBar = {
        let search = UISearchBar()
        search.placeholder = "날짜를 입력해 주세요"
        return search
    }()
    
    private let tableView = {
        let view = UITableView()
        view.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        view.rowHeight = 80
        return view
    }()
    
    private let disposeBag = DisposeBag()
    
    private let viewModel = MovieSearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUI()
        bind()
    }
    
    private func bind() {
        searchBar.rx.searchButtonClicked
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(searchBar.rx.text.orEmpty) { _, query in
                return query
            }
            .map { text -> Int in
                guard let newText = Int(text) else { return 20231107 }
                return newText
            }
            .map { validText -> String in
                    return String(validText)
            }
            .flatMap {
                APIManager.fetchBoxOfficeData(date: $0)
            }
            .subscribe(with: self) { owner, movie in
                let data = movie.boxOfficeResult.dailyBoxOfficeList
                owner.viewModel.movieItems.onNext(data)
            }
            .disposed(by: disposeBag)
        
        
        viewModel.movieItems.bind(to: tableView.rx.items(cellIdentifier: MovieTableViewCell.identifier, cellType: MovieTableViewCell.self)) { (row, element, cell) in
            cell.rankLabel.text = "\(element.rank)위"
            cell.movieNameLabel.text = element.movieNm
            cell.movieOpenLabel.text = element.openDt
        }
        .disposed(by: disposeBag)
        
        
    }
    
    private func setUI() {
        [searchBar, tableView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            // MARK: - 서치바 레이아웃
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
            
        ])
    }
}

