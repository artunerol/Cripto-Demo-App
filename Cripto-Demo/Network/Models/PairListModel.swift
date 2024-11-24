//
//  PairListModel.swift
//  Cripto-Demo
//
//  Created by Artun Erol on 24.11.2024.
//

import Foundation

// MARK: - PairListModel
struct PairListModel: Codable {
    let data: [Pair]
}

// MARK: - Pair
struct Pair: Codable {
    let pairName, pairNormalized: String
    let last: Double
    let volume, dailyPercent: Double
    let numeratorSymbol: String
    var isFavorite: Bool? = false
    
    enum CodingKeys: String, CodingKey {
        case pairName = "pair"
        case pairNormalized
        case last
        case volume
        case dailyPercent
        case numeratorSymbol
        case isFavorite
    }
}
