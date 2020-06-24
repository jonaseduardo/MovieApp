//
//  HomeViewController.swift
//  MovieApp
//
//  Created by Jonathan Garcia on 21/06/2020.
//  Copyright © 2020 Jonathan Garcia. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {
    
    private let kCellIdentifier = "CategoryCell"
    private let kCellSize: CGFloat = 200.0

    @IBOutlet private weak var tableView: UITableView!
    
    private var viewModel: HomeViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configNavBar()        
    }
    
    func configure(withViewModel viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    func configNavBar() {
        title = "Movie App"
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .search, target: self, action: #selector(searchTapped))
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    @objc func searchTapped() {
        
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.itemCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier, for: indexPath) as? CategoryTableViewCell else {
            fatalError("Could not dequeue CategoryTableViewCell")
        }
        let category = viewModel?.getCategory(index: indexPath.row)
        cell.configure(withViewModel: CategoryDataViewModel(category: category))
        cell.layoutIfNeeded()
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kCellSize
    }
}
