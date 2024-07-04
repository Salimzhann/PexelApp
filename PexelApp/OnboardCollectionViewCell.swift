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
    
    func configure(image: String, titleLabel: String, infoLabel: String) {
        self.image.image = UIImage(named: image)
        self.title.text = titleLabel
        self.label.text = infoLabel
        
        setupUI()
    }
    
    func setupUI() {
        
    }
}
