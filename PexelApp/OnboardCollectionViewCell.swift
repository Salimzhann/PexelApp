//
//  OnboardCollectionViewCell.swift
//  PexelApp
//
//  Created by Manas Salimzhan on 04.07.2024.
//

import UIKit

class OnboardCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "OnBoardingCell"
    
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = .gray
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    let image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    func configure(pages: OnboardingModel) {
        self.image.image = UIImage(named: pages.image)
        self.title.text = pages.titleLabel
        self.label.text = pages.label
        
        setupUI()
    }
    
    func setupUI() {
        [image, title, label].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        })
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: self.topAnchor, constant: 104),
            image.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            image.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            image.heightAnchor.constraint(equalToConstant: 266.71),
            
            title.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 30),
            title.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            label.topAnchor.constraint(equalTo: title.bottomAnchor,constant: 5),
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 47),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -47),
        ])
    }
}
