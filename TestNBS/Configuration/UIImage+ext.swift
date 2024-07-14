//
//  UIImage+ext.swift
//  TestNBS
//
//  Created by Dion Lamilga on 13/07/24.
//

import UIKit

extension UIImageView {
    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL string.")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Failed to load image data.")
                return
            }
            
            DispatchQueue.main.sync {
                if let image = UIImage(data: data) {
                    self.image = image
                } else {
                    print("Failed to create image from data.")
                }
            }
        }.resume()
    }
}
