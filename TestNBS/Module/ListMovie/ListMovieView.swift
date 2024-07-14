// 
//  ListMovieView.swift
//  TestNBS
//
//  Created by Dion Lamilga on 13/07/24.
//

import UIKit
import RxSwift
import RxCocoa

class ListMovieView: UIViewController {
    
    @IBOutlet weak var header: Header!
    @IBOutlet weak var listMovieCollection: UICollectionView!
    @IBOutlet weak var label: UILabel!
    
    var presenter: ListMoviePresenter?
    var bag = DisposeBag()
    var savedValue = UserDefaults.standard.object([MovieDetails].self, with: "savedMovie")
    var movieList = [MovieDetails]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension ListMovieView {
    func setup() {
        setupListener()
        setupView()
        setupCollection(listMovieCollection)
    }
    
    func setupView() {
        header.searchBarOn(isOn: true)
        movieList = savedValue ?? []
    }
    
    func setupListener() {
        guard let presenter = presenter else {return}
        presenter.fetchMovie()
    }
    
    func showSimpleAlert(on viewController: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
}

extension ListMovieView: UIScrollViewDelegate {
    func setupCollection(_ collectionView: UICollectionView) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 0
        layout.estimatedItemSize = CGSize(width: (UIScreen.main.bounds.width - 60) / 2, height: 256)
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .none
        collectionView.register(MovieTitleCollectionViewCell.nib(), forCellWithReuseIdentifier: MovieTitleCollectionViewCell.identifier)
        
        let searchTerm = header.searchBar.rx.text.orEmpty
            .distinctUntilChanged()
        
        Observable.combineLatest(presenter?.listMovie ?? BehaviorRelay<[MovieDetails]>(value: []), searchTerm)
            .map {self.filter(data: $0.0, filter: $0.1)}
            .bind(to: collectionView.rx.items(cellIdentifier: MovieTitleCollectionViewCell.identifier,
                                               cellType: MovieTitleCollectionViewCell.self)) { _, item, cell in
                cell.setupCell(data: item)
            } .disposed(by: bag)
        
        collectionView.rx.modelSelected(MovieDetails.self)
            .subscribe(onNext: {[weak self] item in
                guard let self = self else {return}
                let hasDupe = self.movieList.contains { $0.title == item.title }
                self.movieList.append(item)
                let removingDuplicate = self.movieList.removingDuplicates()
                
                let title = hasDupe ? "Sudah Pernah Ditambah" : "Behasil Ditambah"
                let desc = hasDupe ? "Tidak bisa menambhakan yang sudah ada" : "Movie Berhasil Tersimpan"
                self.showSimpleAlert(on: self,
                                     title: title,
                                     message: desc)
                
                UserDefaults.standard.set(object: removingDuplicate, forKey: "savedMovie")
            }).disposed(by: bag)
    }
    
    func filter(data: [MovieDetails], filter: String) -> [MovieDetails] {
        var dataMovie = [MovieDetails]()
        label.isHidden = filter.isEmpty
        if !filter.isEmpty {
            label.text = "Showing result of ‘\(filter)’"
            dataMovie = data.filter {
                $0.title?.range(of: filter, options: .caseInsensitive) != nil
            }
        } else {
            dataMovie = data
        }
        return dataMovie
    }
}
