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
    }()
    
    func configure(image: Photo) {
        self.image = UIImage(data: image)!
        
    }
}
