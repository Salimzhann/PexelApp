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
    
    let timeImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.image = UIImage(systemName: "clock")
        image.tintColor = .white
        return image
    }()
    
    func configure(value: String) {
        label.text = value
        setupUI()
    }
    
    func setupUI() {
        self.layer.cornerRadius = 12
        self.backgroundColor = .systemGray4
        self.addSubview(label)
        self.addSubview(timeImage)
        label.translatesAutoresizingMaskIntoConstraints = false
        timeImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: timeImage.trailingAnchor, constant: 5),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            timeImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            timeImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            timeImage.widthAnchor.constraint(equalToConstant: 15),
            timeImage.heightAnchor.constraint(equalToConstant: 15)
        ])
    }
}
