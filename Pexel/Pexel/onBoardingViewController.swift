//
//  onBoardingViewController.swift
//  Pexel
//
//  Created by Manas Salimzhan on 28.10.2023.
//

import UIKit

class onBoardingViewController: UIViewController {
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var CollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        skipButton.layer.cornerRadius = skipButton.frame.height/2
        nextButton.layer.cornerRadius = nextButton.frame.height/2
    }

    @IBAction func nextButtonClicked(_ sender: UIButton) {
    }
    @IBAction func skipButtonClicked(_ sender: UIButton) {
    }
    

}
