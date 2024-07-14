//
//  MovieTitleCollectionViewCell.swift
//  TestNBS
//
//  Created by Dion Lamilga on 13/07/24.
//

import UIKit

class MovieTitleCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    
    static let identifier = String(describing: MovieTitleCollectionViewCell.self)
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(data: MovieDetails) {
        let url = (ImageMovie.urlImage.rawValue) + (data.image ?? "")
        image.loadImage(from: url)
        title.text = data.title
        subtitle.text = data.overview
    }

}
