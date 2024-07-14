//
//  ImageDetailViewController.swift
//  PexelApp
//
//  Created by Manas Salimzhan on 14.07.2024.
//

import UIKit

class ImageDetailViewController: UIViewController {

    var image: Photo?
       
       let imageView: UIImageView = {
           let iv = UIImageView()
           iv.contentMode = .scaleAspectFit
           iv.translatesAutoresizingMaskIntoConstraints = false
           return iv
       }()
       
       override func viewDidLoad() {
           super.viewDidLoad()
           view.backgroundColor = .systemBackground
           view.addSubview(imageView)
           
           NSLayoutConstraint.activate([
               imageView.topAnchor.constraint(equalTo: view.topAnchor),
               imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
               imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
           ])
           
           if let imageUrl = image?.src.large {
               loadImage(from: imageUrl)
           }
       }
       
       private func loadImage(from urlString: String) {
           guard let url = URL(string: urlString) else { return }
           URLSession.shared.dataTask(with: url) { data, response, error in
               if let data = data, let image = UIImage(data: data) {
                   DispatchQueue.main.async {
                       self.imageView.image = image
                   }
               }
           }.resume()
       }
   }
