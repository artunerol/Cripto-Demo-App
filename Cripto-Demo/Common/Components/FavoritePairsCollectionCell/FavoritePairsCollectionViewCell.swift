//
//  FavoritePairsCollectionViewCell.swift
//  Cripto-Demo
//
//  Created by Artun Erol on 23.11.2024.
//

import UIKit

class FavoritePairsCollectionViewCell: UICollectionViewCell {
    static let identifier = "FavoritePairsCollectionViewCell"
    // MARK: - Outlets
    @IBOutlet weak var collectionContainerView: UIView! {
        didSet {
            collectionContainerView.layer.cornerRadius = 12
            collectionContainerView.clipsToBounds = true
            collectionContainerView.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var pairNameLabel: UILabel! {
        didSet {
            pairNameLabel.textColor = .white
            pairNameLabel.font = AppFont.header.getFont()
        }
    }
    @IBOutlet weak var lastLabel: UILabel! {
        didSet {
            lastLabel.textColor = .white
            lastLabel.font = AppFont.header.getFont()
        }
    }
    @IBOutlet weak var dailyPercentageLabel: UILabel! {
        didSet {
            dailyPercentageLabel.textColor = .white
            dailyPercentageLabel.font = AppFont.header.getFont()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pairNameLabel.text = nil
        lastLabel.text = nil
        dailyPercentageLabel.text = nil
    }
    
    // MARK: - Helpers
    
    func configure(with model: Pair) {
        pairNameLabel.text = model.pair
        lastLabel.text = String(model.last)
        dailyPercentageLabel.text = "%" + String(model.dailyPercent)
        
        if model.dailyPercent > 0 {
            dailyPercentageLabel.textColor = .green
        } else if model.dailyPercent == 0 {
            dailyPercentageLabel.textColor = .lightGray
        } else if model.dailyPercent < 0 {
            dailyPercentageLabel.textColor = .red
        }
    }

}
