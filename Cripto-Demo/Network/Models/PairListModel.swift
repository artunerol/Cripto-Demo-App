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
    let success: Bool
    let code: Int
}

// MARK: - Pair
struct Pair: Codable {
    let pair, pairNormalized: String
    let last, high, low: Double
    let bid, ask, open, average, volume, daily, dailyPercent: Double
    let timestamp: Int
    let denominatorSymbol, numeratorSymbol: String
    let order: Int
    
    enum CodingKeys: String, CodingKey {
        case pair, pairNormalized, timestamp, last, high, low, bid, ask, open
        case volume, average, daily, dailyPercent, denominatorSymbol, numeratorSymbol, order
    }
}
