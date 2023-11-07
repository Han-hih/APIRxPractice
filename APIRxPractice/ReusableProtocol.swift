//
//  ReusableProtocol.swift
//  APIRxPractice
//
//  Created by 황인호 on 11/7/23.
//


import UIKit

protocol ReusableViewProtocol {
    static var identifier: String { get }
}

extension UITableViewCell: ReusableViewProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
