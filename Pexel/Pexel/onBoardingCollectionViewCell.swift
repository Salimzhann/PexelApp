//
//  onBoardingCollectionViewCell.swift
//  Pexel
//
//  Created by Manas Salimzhan on 28.10.2023.
//

import UIKit

class onBoardingCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var stackView: UIStackView!
    static let indentifier: String = "onBoardingCollectionViewCell"
    
    @IBOutlet weak var innerStackView: UIStackView!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(onboardingModel : onboardingModel) {
        imageView.image = UIImage(named: onboardingModel.imageName)
        titleLabel.text = onboardingModel.title
        subtitleLabel.text = onboardingModel.subtitle
        
    }

}
