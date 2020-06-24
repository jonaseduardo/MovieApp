//
//  MovieCollectionViewCell.swift
//  MovieApp
//
//  Created by Jonathan Garcia on 24/06/2020.
//  Copyright © 2020 Jonathan Garcia. All rights reserved.
//

import UIKit

final class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var movieImage: UIImageView!
    
    var viewModel: MovieViewModelProtocol?
    
    func configure(withViewModel viewModel: MovieViewModelProtocol?) {
        self.viewModel = viewModel
        
        bindViewModel()
        viewModel?.loadImage()
    }
    
    func bindViewModel() {
        viewModel?.movieImage.bind { [weak self] image in
            self?.movieImage.image = image
        }
    }
}
