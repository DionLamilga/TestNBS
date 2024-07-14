// 
//  DashboardView.swift
//  TestNBS
//
//  Created by Dion Lamilga on 10/07/24.
//

import UIKit
import RxSwift
import RxCocoa

class DashboardView: UIViewController {
    
    @IBOutlet weak var header: Header!
    @IBOutlet weak var viewSegmentFav: CollectionList!
    @IBOutlet weak var viewSegmentUpcoming: CollectionList!
    @IBOutlet weak var bannerView: BannerView!
    
    var presenter: DashboardPresenter?
    var bag = DisposeBag()
    var autoScrollTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        autoScrollTimer?.invalidate()
        autoScrollTimer = nil
    }
}

extension DashboardView {
    func setup() {
        setupView()
        setupListener()
        setupCollection(viewSegmentFav.collectionView, 
                        listener: presenter?.listMoviePopular ?? BehaviorRelay<[MovieDetails]>(value: []))
        setupCollection(viewSegmentUpcoming.collectionView,
                        listener: presenter?.listMovieUpcoming ?? BehaviorRelay<[MovieDetails]>(value: []))
        setupCollectionBanner(bannerView.collectionBanner)
        startAutoScroll()
    }
    
    func setupListener() {
        guard let presenter = presenter else {return}
        presenter.fetchMoviePopular()
        presenter.fetchMovieUpcoming()
        presenter.fetchTopMovie()
    }
    
    func setupView() {
        viewSegmentUpcoming.title.text = "Popular Movies"
        viewSegmentUpcoming.title.text = "Coming Soon"
    }
    
    func startAutoScroll() {
        autoScrollTimer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(scrollCollectionView), userInfo: nil, repeats: true)
    }
    
    @objc func scrollCollectionView() {
        let collectionView = bannerView.collectionBanner
        let visibleItems = collectionView?.indexPathsForVisibleItems
        guard let lastItemIndex = collectionView?.indexPathsForVisibleItems.last?.item else { return }
        let nextIndex = (lastItemIndex + 1) % (collectionView?.numberOfItems(inSection: 0) ?? 0)
        let nextIndexPath = IndexPath(item: nextIndex, section: 0)
        collectionView?.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
    }
}

extension DashboardView: UIScrollViewDelegate {
    func setupCollectionBanner(_ collectionView: UICollectionView) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width, height: 260)
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .none
        collectionView.register(BannerCollectionViewCell.nib(), forCellWithReuseIdentifier: BannerCollectionViewCell.identifier)
        
        presenter?.topMovie.bind(to: collectionView.rx.items(cellIdentifier: BannerCollectionViewCell.identifier, 
                                                             cellType: BannerCollectionViewCell.self)) { _, item, cell in
            cell.setupCell(image: item.backdrop ?? "")
        } .disposed(by: bag)
        
        collectionView.rx.setDelegate(self)
            .disposed(by: bag)
    }
    
    func setupCollection(_ collectionView: UICollectionView, listener: BehaviorRelay<[MovieDetails]>) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 0
        layout.estimatedItemSize = CGSize(width: 100, height: 156)
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .none
        collectionView.register(MovieCollectionViewCell.nib(), forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        
        listener.bind(to: collectionView.rx.items(cellIdentifier: MovieCollectionViewCell.identifier,
                                                  cellType: MovieCollectionViewCell.self)) { _, item, cell in
            cell.setupCell(image: item.image ?? "")
        } .disposed(by: bag)
        
        collectionView.rx.setDelegate(self)
            .disposed(by: bag)
    }
}


