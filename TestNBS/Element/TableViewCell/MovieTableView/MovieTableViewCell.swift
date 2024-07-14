//
//  MovieTableViewCell.swift
//  TestNBS
//
//  Created by Dion Lamilga on 14/07/24.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var tahun: UILabel!
    @IBOutlet weak var desc: UILabel!
    
    static let identifier = String(describing: MovieTableViewCell.self)
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(item: MovieDetails) {
        let url = (ImageMovie.urlImage.rawValue) + (item.backdrop ?? "")
        imageMovie.loadImage(from: url)
        title.text = item.title
        tahun.text = item.date
        desc.text = item.overview
    }
    
}
