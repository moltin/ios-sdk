//
//  UIImageView.swift
//  moltin iOS Example
//
//  Created by Craig Tweedy on 29/03/2018.
//

import UIKit

extension UIImageView {
    
    func load(urlString string: String?) {
        guard let imageUrl = string,
            let url = URL(string: imageUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
        }.resume()
    }
}
