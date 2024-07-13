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
    
    var pictureArray: [Photo] {
        return searchPhoto?.photos ?? []
    }
    
    let searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "Enter here"
        return bar
    }()
    
    let imagesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(PicturesCollectionViewCell.self, forCellWithReuseIdentifier: PicturesCollectionViewCell.identifier)
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionView()
        fetchData()
    }
    
    func setupCollectionView() {
        imagesCollectionView.dataSource = self
        imagesCollectionView.delegate = self
    }
    
    func setupUI() {
        searchBar.delegate = self
        view.backgroundColor = .systemBackground
        
        [searchBar, imagesCollectionView].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        })
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchBar.heightAnchor.constraint(equalToConstant: 40),
            
            imagesCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            imagesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imagesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
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
            URLQueryItem(name: "per_page", value: "50")
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
       }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pictureArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imagesCollectionView.dequeueReusableCell(withReuseIdentifier: PicturesCollectionViewCell.identifier, for: indexPath) as! PicturesCollectionViewCell
        cell.configure(image: pictureArray[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width / 3 - 40
        return CGSize(width: width, height: width)
    }


}
