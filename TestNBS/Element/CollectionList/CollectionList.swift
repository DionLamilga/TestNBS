//
//  CollectionList.swift
//  TestNBS
//
//  Created by Dion Lamilga on 13/07/24.
//

import Foundation
import UIKit

class CollectionList: UIView {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var title: UILabel!
    
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
        guard let view = self.loadViewFromNib(nibName: "CollectionList") else { return }
        self.addSubview(view)
    }
}
