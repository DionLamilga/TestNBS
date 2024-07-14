//
//  MovieCollectionViewCell.swift
//  TestNBS
//
//  Created by Dion Lamilga on 13/07/24.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    
    static let identifier = String(describing: MovieCollectionViewCell.self)
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(image: String) {
        let url = (ImageMovie.urlImage.rawValue) + (image)
        self.image.loadImage(from: url)
    }

}
