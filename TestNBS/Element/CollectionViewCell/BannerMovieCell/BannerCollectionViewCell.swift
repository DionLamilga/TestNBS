//
//  BannerCollectionViewCell.swift
//  TestNBS
//
//  Created by Dion Lamilga on 14/07/24.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageBanner: UIImageView!
    
    static let identifier = String(describing: BannerCollectionViewCell.self)
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(image: String) {
        let url = (ImageMovie.urlImage.rawValue) + (image)
        imageBanner.loadImage(from: url)
    }
}
