//
//  CategoryTableViewCell.swift
//  MovieApp
//
//  Created by Jonathan Garcia on 21/06/2020.
//  Copyright © 2020 Jonathan Garcia. All rights reserved.
//

import UIKit

final class CategoryTableViewCell: UITableViewCell {
    
    private let kCellIdentifier = "MovieCell"
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var viewModel: CategoryDataViewModelProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configCollectionView()
    }
    
    func configure(withViewModel viewModel: CategoryDataViewModelProtocol?) {
        self.viewModel = viewModel
        
        bindViewModel()
        viewModel?.getMovies(page: 0)
        titleLabel.text = viewModel?.categoryName
    }
    
    func configCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func bindViewModel() {
        viewModel?.movies.bind { [weak self] _ in
            self?.collectionView.reloadData()
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
    
}
