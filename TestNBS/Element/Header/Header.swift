//
//  Header.swift
//  TestNBS
//
//  Created by Dion Lamilga on 13/07/24.
//

import Foundation
import UIKit

class Header: UIView {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var separatorView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func loadViewFromNib(nibName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    func setupView() {
        guard let view = self.loadViewFromNib(nibName: "Header") else { return }
        self.addSubview(view)
    }
    
    func searchBarOn(isOn: Bool) {
        image.isHidden = isOn
        imageIcon.isHidden = !isOn
        imageIcon.image = UIImage(systemName: "magnifyingglass")
        searchBar.isHidden = !isOn
        searchBar.placeholder = "Search"
        separatorView.isHidden = !isOn
    }
}
