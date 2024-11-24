//
//  PairListVC.swift
//  Cripto-Demo
//
//  Created by Artun Erol on 23.11.2024.
//

import UIKit

class PairListVC: BaseViewController {
    // MARK: - Outlets
    @IBOutlet private weak var favoritesCollectionView: UICollectionView!
    @IBOutlet private weak var pairsTableView: UITableView!
    let asd: Double = 32.1234897
    
    // MARK: - Variables
    private let viewModel = PairListVM()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        viewModel.fetchList()
    }
}


// MARK: - Helpers
extension PairListVC {
    private func configureUI() {
        view.backgroundColor = .red
        favoritesCollectionView.delegate = self
        favoritesCollectionView.dataSource = self
        favoritesCollectionView.register(UINib(nibName: FavoritePairsCollectionViewCell.getNibName(),
                                               bundle: nil),
                                         forCellWithReuseIdentifier: FavoritePairsCollectionViewCell.identifier)
        
        pairsTableView.delegate = self
        pairsTableView.dataSource = self
        pairsTableView.register(UINib(nibName: PairListTableViewCell.getNibName(),
                                      bundle: nil),
                                forCellReuseIdentifier: PairListTableViewCell.identifier)
    }
}

// MARK: - CollectionView delegate/datasource
extension PairListVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoritePairsCollectionViewCell.identifier,
                                                       for: indexPath) as? FavoritePairsCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
}

// MARK: - CollectionView delegate/datasource
extension PairListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PairListTableViewCell.identifier,
                                                       for: indexPath) as? PairListTableViewCell else { return UITableViewCell() }
        return cell
    }
}
