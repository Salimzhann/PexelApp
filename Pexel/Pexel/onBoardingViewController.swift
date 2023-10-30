//
//  onBoardingViewController.swift
//  Pexel
//
//  Created by Manas Salimzhan on 28.10.2023.
//

import UIKit

class onBoardingViewController: UIViewController {
    @IBOutlet weak var nextButton: UIButton!
    var pages = [onboardingModel]() {
        didSet {
            CollectionView.reloadData()
        }
    }
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var CollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CollectionView.register(UINib(nibName: onBoardingCollectionViewCell.indentifier, bundle: nil), forCellWithReuseIdentifier: onBoardingCollectionViewCell.indentifier)
        CollectionView.dataSource = self
        CollectionView.delegate = self
        generatePages()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        skipButton.layer.cornerRadius = skipButton.frame.height/2
        nextButton.layer.cornerRadius = nextButton.frame.height/2
    }
    
    func generatePages() {
        pages = [onboardingModel(imageName: "onboarding1", title: "Access Anywhere", subtitle: "The video call feature can be accessed from anywhere in your house to help you."),
                 onboardingModel(imageName: "onboarding2", title: "Don’t Feel Alone", subtitle: "Nobody likes to be alone and the built-in group video call feature helps you connect."),
        onboardingModel(imageName: "onboarding3", title: "Happiness", subtitle: "While working the app reminds you to smile, laugh, walk and talk with those who matters.")
        ]
    }

    @IBAction func nextButtonClicked(_ sender: UIButton) {
        
        if pageControl.currentPage == pageControl.numberOfPages - 1 {
            start()
    
        }else{
            pageControl.currentPage += 1
            
            let x: CGFloat = CollectionView.frame.width * CGFloat(pageControl.currentPage)
            CollectionView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
            lastPage()
        }
    }
    @IBAction func skipButtonClicked(_ sender: UIButton) {
        start()
    }
    
    func start() {
        
    }
    
    func lastPage() {
        if pageControl.currentPage == pageControl.numberOfPages - 1 {
            skipButton.isHidden = true
            nextButton.setTitle("Start", for: .normal)
        }else {
            skipButton.isHidden = false
            nextButton.setTitle("Next", for: .normal)
        }
    }

}

extension onBoardingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: onBoardingCollectionViewCell.indentifier, for: indexPath) as! onBoardingCollectionViewCell
        
        let onboardingModel = pages[indexPath.item]
        cell.setup(onboardingModel: onboardingModel)
        return cell
    }
}


extension onBoardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}

extension onBoardingViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x/scrollView.frame.width)
       lastPage()
    }
}
