//
//  PicturesCollectionViewCell.swift
//  PexelApp
//
//  Created by Manas Salimzhan on 05.07.2024.
//

import UIKit

class PicturesCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "pictureCell"
    
    var image: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    func configure(image: Photo) {
        guard let mediumImage = URL(string: image.src.medium) else {
            print("something wrong with mediumImage")
            return
        }
        URLSession.shared.dataTask(with: mediumImage) { data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    self.image.image = UIImage(data: data)
                }
            }
            if let error = error {
                print(error.localizedDescription)
            }
        }
        setupUI()
    }
    
    func setupUI() {
        self.addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: self.topAnchor),
            image.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            image.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
