//
//  PairListVM.swift
//  Cripto-Demo
//
//  Created by Artun Erol on 23.11.2024.
//

import Foundation

enum PairListDataHandler {
    case updateFavoritePairs
    case fail(CustomError)
    case updatePairLists
}

class PairListVM {
    private let network = NetworkLayer()
    var dataChangeHandler: ((PairListDataHandler) -> Void)?
    
    var pairList: [Pair] = []
    var favoritePairList: [Pair] = []
    
    func fetchList() {
        network
            .request(model: PairListModel.self,
                     apiURL: .pairList) { result in
                switch result {
                case .success(let response):
                    self.toggleFavorite(for: response.data)
                case .failure(let error):
                    self.dataChangeHandler?(.fail(error))
                }
            }
    }
    
    func updateFavoritePairs(with pairModel: Pair, isFavorite: Bool) {
        if isFavorite {
            favoritePairList.append(pairModel)
        } else {
            favoritePairList.removeAll(where: {$0.pairName == pairModel.pairName})
        }
        
        UserDefaults.standard.saveData(data: favoritePairList, key: UserdefaultsKeys.favoritePairs)
        dataChangeHandler?(.updateFavoritePairs)
    }
    
    private func getFavoritePairs() {
        let savedFavoritePairList = UserDefaults.standard.getData(with: UserdefaultsKeys.favoritePairs, for: [Pair].self) ?? []
        favoritePairList = savedFavoritePairList
    }
    
    private func toggleFavorite(for responsePair: [Pair]) {
        getFavoritePairs()
        
        responsePair.forEach { [weak self] responsePair in
            guard let self = self else { return }
            let isFavorite = favoritePairList.contains(where: {$0.pairName == responsePair.pairName })
            var pair = responsePair
            
            pair.isFavorite = isFavorite
            self.pairList.append(pair)
            self.dataChangeHandler?(.updatePairLists)
        }
    }
}
