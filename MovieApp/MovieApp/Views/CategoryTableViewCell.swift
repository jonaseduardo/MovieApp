//
//  CategoryTableViewCell.swift
//  MovieApp
//
//  Created by Jonathan Garcia on 21/06/2020.
//  Copyright © 2020 Jonathan Garcia. All rights reserved.
//

import UIKit

protocol CategoryTableViewCellDelegate: class {
    func categoryTableViewCell(_ categoryTableViewCell: CategoryTableViewCell, didSelectMovie movieId: String)
}

final class CategoryTableViewCell: UITableViewCell {
    
    private let kCellIdentifier = "MovieCell"
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    weak var delegate: CategoryTableViewCellDelegate?
    
    var viewModel: CategoryDataViewModelProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configCollectionView()
    }
    
    func configure(withViewModel viewModel: CategoryDataViewModelProtocol?) {
        self.viewModel = viewModel
        
        bindViewModel()
        viewModel?.getMovies()
        titleLabel.text = viewModel?.categoryName
    }
    
    func configCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func reload(collectionView: UICollectionView) {
        
        let contentOffset = collectionView.contentOffset
        collectionView.reloadData()
        collectionView.layoutIfNeeded()
        collectionView.setContentOffset(contentOffset, animated: false)
    }
    
    func bindViewModel() {
        viewModel?.movies.bind { [weak self] _ in
            guard let self = self else { return }
            self.reload(collectionView: self.collectionView)
        }
    }
}

extension CategoryTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.itemCount ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellIdentifier, for: indexPath) as? MovieCollectionViewCell else {
            fatalError("Could not dequeue MovieCollectionViewCell")
        }
        let viewModel = self.viewModel?.getMovieViewModel(index: indexPath.row)
        cell.configure(withViewModel: viewModel)
        return cell
    }
}

extension CategoryTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewModel = self.viewModel?.getMovieViewModel(index: indexPath.row)
        if let movieId = viewModel?.movieId {
            delegate?.categoryTableViewCell(self, didSelectMovie: movieId)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let itemCount = viewModel?.itemCount else { return }
        if indexPath.row == itemCount - 1 {
            viewModel?.getMovies()
        }
    }
}

extension CategoryTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100.0 , height: 150.0)
    }
}
