//
//  MovieCollectionViewCell.swift
//  APIRxPractice
//
//  Created by 황인호 on 11/7/23.
//

import UIKit
import RxSwift

final class MovieTableViewCell: UITableViewCell {
    let rankLabel = {
        let label = UILabel()
        label.text = "1위"
        return label
    }()
    
    let movieNameLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.text = "남자가 사랑할 때"
        return label
    }()
    
    let movieOpenLabel = {
        let label = UILabel()
        label.text = "2002년"
        return label
    }()
    
    private var disposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    private func setUI() {
        [rankLabel, movieNameLabel, movieOpenLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            rankLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            rankLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            movieNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            movieNameLabel.leadingAnchor.constraint(equalTo: rankLabel.trailingAnchor, constant: 10),
            
            movieOpenLabel.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor, constant: 10),
            movieOpenLabel.leadingAnchor.constraint(equalTo: movieNameLabel.leadingAnchor)
        ])
        
        
        
    }
    
}
