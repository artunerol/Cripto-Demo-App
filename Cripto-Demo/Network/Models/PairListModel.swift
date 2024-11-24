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
    let pair, pairNormalized: String
    let last: Double
    let volume, dailyPercent: Double
    let numeratorSymbol: String
}
