//
//  ViewController.swift
//  PexelApp
//
//  Created by Manas Salimzhan on 02.07.2024.
//

import UIKit

class OnboardingView: UIViewController {
    
    var pages: [OnboardingModel] = []
    var currentPage = 0
    
    let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 25
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let skipButton: UIButton = {
        let button = UIButton()
        button.setTitle("Skip", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.alpha = 0.5
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return button
    }()

    let pictureCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.isPagingEnabled = true
        cv.register(OnboardCollectionViewCell.self, forCellWithReuseIdentifier: OnboardCollectionViewCell.identifier)
        return cv
    }()
    
    let pageControl: UIPageControl = {
        let ping = UIPageControl()
        ping.numberOfPages = 3
        ping.currentPage = 0
        ping.pageIndicatorTintColor = .gray
        ping.currentPageIndicatorTintColor = .black
        return ping
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        setupCollectionView()
        pageGenerate()
    }

    func setupCollectionView() {
        pictureCollectionView.dataSource = self
        pictureCollectionView.delegate = self
    }
    
    func pageGenerate() {
        pages = [
            OnboardingModel(image: "1", titleLabel: "Access Anywhere", label: "The video call feature can be accessed from anywhere in your house to help you."),
            OnboardingModel(image: "2", titleLabel: "Don’t Feel Alone", label: "Nobody likes to be alone and the built-in group video call feature helps you connect."),
            OnboardingModel(image: "3", titleLabel: "Happiness", label: "While working the app reminds you to smile, laugh, walk and talk with those who matters.")
        ]
    }

    func setupUI() {
        [pictureCollectionView, pageControl, nextButton, skipButton].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        })
        
        NSLayoutConstraint.activate([
            pictureCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pictureCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pictureCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pictureCollectionView.heightAnchor.constraint(equalToConstant: 526),
            
            pageControl.topAnchor.constraint(equalTo: pictureCollectionView.bottomAnchor, constant: 10),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            nextButton.topAnchor.constraint(equalTo: pictureCollectionView.bottomAnchor, constant: 110),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            nextButton.widthAnchor.constraint(equalToConstant: 160),
            
            skipButton.topAnchor.constraint(equalTo: pictureCollectionView.bottomAnchor, constant: 115),
            skipButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -20),
            skipButton.heightAnchor.constraint(equalToConstant: 40),
            skipButton.widthAnchor.constraint(equalToConstant: 140)
        ])
    }
    
    @objc func nextButtonTapped() {
        if currentPage < 2 {
            currentPage += 1
            pageControl.currentPage = currentPage
            nextButton.setTitle("Next", for: .normal)
            pictureCollectionView.scrollToItem(at: IndexPath(item: currentPage, section: 0), at: .centeredHorizontally, animated: true)
            if currentPage == 2 {
                nextButton.setTitle("Start", for: .normal)
                skipButton.isHidden = true
            }
        }
    }
}

extension OnboardingView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = pictureCollectionView.dequeueReusableCell(withReuseIdentifier: OnboardCollectionViewCell.identifier, for: indexPath) as! OnboardCollectionViewCell
        cell.configure(pages: pages[indexPath.item])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let pageIndex = round(scrollView.contentOffset.x / scrollView.frame.width)
            currentPage = Int(pageIndex)
            pageControl.currentPage = Int(pageIndex)
        
        if pageControl.currentPage == 2 {
            skipButton.isHidden = true
            nextButton.setTitle("Start", for: .normal)
        } else {
            skipButton.isHidden = false
            nextButton.setTitle("Next", for: .normal)
        }
       }
    
    
}

