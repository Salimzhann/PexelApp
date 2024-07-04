//
//  ViewController.swift
//  PexelApp
//
//  Created by Manas Salimzhan on 02.07.2024.
//

import UIKit

class OnboardingView: UIViewController {
    
    var pages: [OnboardingModel] = [] {
        didSet {
            pictureCollectionView.reloadData()
        }
    }
    var currentPage = 0

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
        [pictureCollectionView, pageControl].forEach({
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
        ])
    }
}

extension OnboardingView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = pictureCollectionView.dequeueReusableCell(withReuseIdentifier: OnboardCollectionViewCell.identifier, for: indexPath) as! OnboardCollectionViewCell
        pageControl.currentPage = indexPath.item
        cell.configure(pages: pages[indexPath.item])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
        
    }
    
    
}

