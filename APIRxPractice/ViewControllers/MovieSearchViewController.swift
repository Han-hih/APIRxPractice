//
//  ViewController.swift
//  APIRxPractice
//
//  Created by 황인호 on 11/6/23.
//

import UIKit
import RxSwift
import RxCocoa

class MovieSearchViewController: UIViewController {

    let searchBar = {
        let search = UISearchBar()
        search.placeholder = "영화를 검색해 주세요."
        return search
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUI()
    }

    func setUI() {
        [searchBar].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            // MARK: - 서치바 레이아웃
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            

        ])
    }
}

