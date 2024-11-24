//
//  PairListVM.swift
//  Cripto-Demo
//
//  Created by Artun Erol on 23.11.2024.
//

import Foundation

class PairListVM {
    private let network = NetworkLayer()
    
    func fetchList() {
        network
            .request(model: PairListModel.self,
                     apiURL: .pairList) { result in
                switch result {
                case .success(let response):
                    print(response)
                case .failure(let error):
                    break
                }
            }
    }
}
