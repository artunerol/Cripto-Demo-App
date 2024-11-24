//
//  PairListVC.swift
//  Cripto-Demo
//
//  Created by Artun Erol on 23.11.2024.
//

import UIKit

class PairListVC: BaseViewController {
    // MARK: - Outlets
    @IBOutlet private weak var favoriteLabel: UILabel!
    @IBOutlet private weak var favoritesCollectionView: UICollectionView!
    @IBOutlet private weak var pairsTableView: UITableView!
    
    // MARK: - Variables
    private let viewModel = PairListVM()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetch()
        listenDataHandler()
    }
    
    private func listenDataHandler() {
        viewModel.dataChangeHandler = { change in
            switch change {
            case .updateFavoritePairs:
                DispatchQueue.main.async {
                    self.favoriteLabel.isHidden = self.viewModel.favoritePairList.isEmpty
                    self.favoritesCollectionView.isHidden = self.viewModel.favoritePairList.isEmpty
                    
                    self.favoritesCollectionView.reloadData()
                }
            case .fail(_):
                print("Any kind of error handling pop-up can be shown here")
                self.toggleLoading(false)
            case .updatePairLists:
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.toggleLoading(false)
                }
                
                DispatchQueue.main.async {
                    self.favoriteLabel.isHidden = self.viewModel.favoritePairList.isEmpty
                    self.favoritesCollectionView.isHidden = self.viewModel.favoritePairList.isEmpty
                    
                    self.favoritesCollectionView.reloadData()
                    self.pairsTableView.reloadData()
                }
            }
        }
    }
}

// MARK: - Helpers
extension PairListVC {
    private func configureUI() {
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
    
    private func fetch() {
        toggleLoading(true)
        viewModel.fetchList()
    }
}

// MARK: - CollectionView delegate/datasource
extension PairListVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 80, height: 80)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.favoritePairList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoritePairsCollectionViewCell.identifier,
                                                            for: indexPath) as? FavoritePairsCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(with: viewModel.favoritePairList[indexPath.row])
        return cell
    }
}

// MARK: - CollectionView delegate/datasource
extension PairListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.pairList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PairListTableViewCell.identifier,
                                                       for: indexPath) as? PairListTableViewCell else { return UITableViewCell() }
        cell.delegate = self
        cell.configure(with: viewModel.pairList[indexPath.row])
        return cell
    }
}

// MARK: - DidTapFavorite
extension PairListVC: PairListCellDelegate {
    func didTapFavorite(pairModel: Pair?, isFavorite: Bool) {
        guard let pairUnwrapped = pairModel else { return }
        viewModel.updateFavoritePairs(with: pairUnwrapped, isFavorite: isFavorite)
    }
}
