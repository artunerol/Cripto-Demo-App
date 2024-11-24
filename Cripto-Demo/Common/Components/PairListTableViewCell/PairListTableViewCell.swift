//
//  PairListTableViewCell.swift
//  Cripto-Demo
//
//  Created by Artun Erol on 23.11.2024.
//

import UIKit

class PairListTableViewCell: UITableViewCell {
    static let identifier = "PairListTableViewCell"
    
    // MARK: - Outlets
    @IBOutlet private weak var cellContentView: UIView!
    @IBOutlet private weak var pairNameLabel: UILabel! {
        didSet {
            pairNameLabel.textColor = .white
            pairNameLabel.font = AppFont.header.getFont()
        }
    }
    @IBOutlet private weak var lastValueLabel: UILabel! {
        didSet {
            lastValueLabel.textColor = .white
            lastValueLabel.font = AppFont.header.getFont()
        }
    }
    @IBOutlet private weak var dailyPercentageLabel: UILabel! {
        didSet {
            dailyPercentageLabel.font = AppFont.description.getFont()
            dailyPercentageLabel.textColor = .green
        }
    }
    @IBOutlet private weak var volumeLabel: UILabel! {
        didSet {
            volumeLabel.textColor = .white
            volumeLabel.font = AppFont.description.getFont()
        }
    }
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        cellContentView.backgroundColor = AppColor.background.getColor()
        // Initialization code
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        pairNameLabel.text = nil
        lastValueLabel.text = nil
        dailyPercentageLabel.text = nil
        volumeLabel.text = nil
    }
    // MARK: - Helpers
    
    func configure(with model: Pair) {
        pairNameLabel.text = model.pair
        lastValueLabel.text = String(model.last)
        dailyPercentageLabel.text = "%" + String(model.dailyPercent)
        volumeLabel.text = String(model.dailyPercent) + model.numeratorSymbol
        
        if model.dailyPercent > 0 {
            dailyPercentageLabel.textColor = .green
        } else if model.dailyPercent == 0 {
            dailyPercentageLabel.textColor = .lightGray
        } else if model.dailyPercent < 0 {
            dailyPercentageLabel.textColor = .red
        }
    }
}
