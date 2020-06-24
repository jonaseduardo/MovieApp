//
//  DetailMovieViewController.swift
//  MovieApp
//
//  Created by Jonathan Garcia on 22/06/2020.
//  Copyright © 2020 Jonathan Garcia. All rights reserved.
//

import UIKit

final class DetailMovieViewController: UIViewController {
    
    @IBOutlet private weak var posterImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var voteAverageLabel: UILabel!
    @IBOutlet private weak var overviewLabel: UILabel!
    
    var viewModel: DetailMovieViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Movie Detail"
        viewModel?.getDetailMovie()
    }
    
    func configure(withViewModel viewModel: DetailMovieViewModelProtocol) {
        self.viewModel = viewModel
        bindViewModel()
    }
    
    func bindViewModel() {
        viewModel?.movieIsLoaded.bind { [weak self] isLoaded in
            if isLoaded {
                self?.showMovieData()
            }
        }
        viewModel?.movieImage.bind { [weak self] image in
            self?.posterImage.image = image
        }
    }
    
    func showMovieData() {
        titleLabel.text = viewModel?.title
        releaseDateLabel.text = viewModel?.releaseDate
        voteAverageLabel.text = viewModel?.voteAverage
        overviewLabel.text = viewModel?.overview
    }
}
