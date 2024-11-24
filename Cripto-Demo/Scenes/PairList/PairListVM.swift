//
//  PairListVM.swift
//  Cripto-Demo
//
//  Created by Artun Erol on 23.11.2024.
//

import Foundation

enum PairListNetworkHandler {
    case success
    case fail(CustomError)
}

class PairListVM {
    private let network = NetworkLayer()
    var didFinishNetwork: ((PairListNetworkHandler) -> Void)?
    
    var pairList: [Pair] = []
    
    func fetchList() {
        network
            .request(model: PairListModel.self,
                     apiURL: .pairList) { result in
                switch result {
                case .success(let response):
                    self.pairList = response.data
                    self.didFinishNetwork?(.success)
                case .failure(let error):
                    self.didFinishNetwork?(.fail(error))
                }
            }
    }
}
