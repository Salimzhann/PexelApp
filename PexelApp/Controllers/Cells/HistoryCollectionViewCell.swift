//
//  HistoryCollectionViewCell.swift
//  PexelApp
//
//  Created by Manas Salimzhan on 13.07.2024.
//

import UIKit

class HistoryCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "HistoryCell"
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    func configure(value: String) {
        label.text = value
        setupUI()
    }
    
    func setupUI() {
        self.layer.cornerRadius = 12
        self.backgroundColor = .systemGray4
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
