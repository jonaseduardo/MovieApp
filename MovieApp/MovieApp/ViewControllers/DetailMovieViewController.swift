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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
