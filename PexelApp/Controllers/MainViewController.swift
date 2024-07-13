//
//  MainViewController.swift
//  PexelApp
//
//  Created by Manas Salimzhan on 05.07.2024.
//

import UIKit

class MainViewController: UIViewController {
    let key: String = "F834iRfCFBFzNmy444aZAziZRmHTmMZbpdxdexyKu7t99MUvGyaw9mEI"
    
    var searchPhoto: PictureResponse? {
        didSet {
            DispatchQueue.main.async {
                self.imagesCollectionView.reloadData()
            }
        }
    }
    
    var historyArray: [String] = []
    
    var pictureArray: [Photo] {
        return searchPhoto?.photos ?? []
    }
    
    let searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "Enter here"
        return bar
    }()
    
    let historyCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.register(HistoryCollectionViewCell.self, forCellWithReuseIdentifier: HistoryCollectionViewCell.identifier)
        return cv
    }()
    
    let imagesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsVerticalScrollIndicator = false
        cv.register(PicturesCollectionViewCell.self, forCellWithReuseIdentifier: PicturesCollectionViewCell.identifier)
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionView()
    }
    
    func setupCollectionView() {
        imagesCollectionView.dataSource = self
        imagesCollectionView.delegate = self
        
        historyCollectionView.dataSource = self
        historyCollectionView.delegate = self
    }
    
    func setupUI() {
        searchBar.delegate = self
        view.backgroundColor = .systemBackground
        
        [searchBar, imagesCollectionView, historyCollectionView].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        })
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchBar.heightAnchor.constraint(equalToConstant: 40),
            
            historyCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            historyCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            historyCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -5),
            historyCollectionView.heightAnchor.constraint(equalToConstant: 30),
            
            imagesCollectionView.topAnchor.constraint(equalTo: historyCollectionView.bottomAnchor, constant: 10),
            imagesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            imagesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            imagesCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func fetchData() {
        guard let value = searchBar.text else {
            print("Error from searchBAr")
            return
        }
        
        guard !value.isEmpty else {
            print("value is empty")
            return
        }
        
        let endpoint = "https://api.pexels.com/v1/search"
        
        var urlComponents = URLComponents(string: endpoint)
        let parameters = [
            URLQueryItem(name: "query", value: value),
            URLQueryItem(name: "per_page", value: "100")
        ]
        
        urlComponents?.queryItems = parameters
        
        guard let url = urlComponents?.url else {
            print("url is nil")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        urlRequest.addValue(key, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let data = data {
                do {
                    let ans = try JSONDecoder().decode(PictureResponse.self, from: data)
                    self.searchPhoto = ans
                }
                catch {
                    print(error.localizedDescription)
                }
            }
            if let error = error {
                print(error.localizedDescription)
            }
        }.resume()
            }
    func addToHistory() {
        guard let value = searchBar.text else {
            print("searchBar is nil")
            return
        }
        guard !value.isEmpty else {
            print("searchBar is empty")
            return
        }
        
        historyArray.append(value)
        historyCollectionView.reloadData()
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
           searchBar.showsCancelButton = true
       }
       
       func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
           searchBar.resignFirstResponder()
       }
       
       func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
           searchBar.showsCancelButton = false
       }
       
       func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
           searchBar.resignFirstResponder()
           fetchData()
           addToHistory()
       }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == imagesCollectionView {
            return pictureArray.count
        } else {
            return historyArray.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == imagesCollectionView {
            let cell = imagesCollectionView.dequeueReusableCell(withReuseIdentifier: PicturesCollectionViewCell.identifier, for: indexPath) as! PicturesCollectionViewCell
            cell.configure(image: pictureArray[indexPath.item])
            return cell
        } else {
            let cell = historyCollectionView.dequeueReusableCell(withReuseIdentifier: HistoryCollectionViewCell.identifier, for: indexPath) as! HistoryCollectionViewCell
            cell.configure(value: historyArray[indexPath.item])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == imagesCollectionView {
            let padding: CGFloat = 20
            let width = (view.frame.width - padding) / 3
            return CGSize(width: width, height: width)
        } else {
            let label = UILabel()
            label.text = historyArray[indexPath.item]
            label.sizeToFit()
            return CGSize(width: label.frame.width + 40, height: 30)
        }
    }


}
