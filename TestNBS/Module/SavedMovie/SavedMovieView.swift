// 
//  SavedMovieView.swift
//  TestNBS
//
//  Created by Dion Lamilga on 13/07/24.
//

import UIKit
import RxSwift
import RxCocoa

class SavedMovieView: UIViewController {
    
    @IBOutlet weak var header: Header!
    @IBOutlet weak var tableMovie: UITableView!
    
    var presenter: SavedMoviePresenter?
    
    var bag = DisposeBag()
    var savedMovie = UserDefaults.standard.object([MovieDetails].self, with: "savedMovie")

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        savedMovie = UserDefaults.standard.object([MovieDetails].self, with: "savedMovie")
        presenter?.savedMovie.accept(savedMovie ?? [])
    }
}

extension SavedMovieView {
    func setup() {
        setupTable(tableMovie)
        header.searchBarOn(isOn: true)
    }
}

extension SavedMovieView: UIScrollViewDelegate {
    func setupTable(_ tableView: UITableView) {
        tableView.backgroundColor = .none
        tableView.separatorStyle = .none
        
        tableView.register(MovieTableViewCell.nib(), forCellReuseIdentifier: MovieTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        
        let searchTerm = header.searchBar.rx.text.orEmpty
            .distinctUntilChanged()
        
        Observable.combineLatest(presenter?.savedMovie ?? BehaviorRelay<[MovieDetails]>(value: []), searchTerm)
            .map {self.filter(data: $0.0, filter: $0.1)}
            .bind(to: tableView.rx.items(cellIdentifier: MovieTableViewCell.identifier, cellType: MovieTableViewCell.self)) { row, item, cell in
            cell.setupCell(item: item)
        }.disposed(by: bag)
        
        tableView.rx.setDelegate(self).disposed(by: bag)
    }
    
    func filter(data: [MovieDetails], filter: String) -> [MovieDetails] {
        var dataMovie = [MovieDetails]()
        if !filter.isEmpty {
            dataMovie = data.filter {
                $0.title?.range(of: filter, options: .caseInsensitive) != nil
            }
        } else {
            dataMovie = data
        }
        return dataMovie
    }
}
