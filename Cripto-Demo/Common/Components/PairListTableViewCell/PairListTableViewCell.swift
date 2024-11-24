//
//  PairListTableViewCell.swift
//  Cripto-Demo
//
//  Created by Artun Erol on 23.11.2024.
//

import UIKit

protocol PairListCellDelegate: AnyObject {
    func didTapFavorite(pairModel: Pair?, isFavorite: Bool)
}

class PairListTableViewCell: UITableViewCell {
    weak var delegate: (any PairListCellDelegate)?
    static let identifier = "PairListTableViewCell"
    private var isFavorite: Bool = false
    var pairModel: Pair?
    
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
    
    @IBOutlet weak var favoriteButtonOutlet: UIButton!
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        cellContentView.backgroundColor = AppColor.background.getColor()
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
        self.pairModel = model
        pairNameLabel.text = model.pairName
        lastValueLabel.text = String(model.last)
        dailyPercentageLabel.text = "%" + String(model.dailyPercent)
        volumeLabel.text = String(model.dailyPercent) + model.numeratorSymbol
        isFavorite = model.isFavorite ?? false
        toggleFavoriteButtonImage()
        
        if model.dailyPercent > 0 {
            dailyPercentageLabel.textColor = .green
        } else if model.dailyPercent == 0 {
            dailyPercentageLabel.textColor = .lightGray
        } else if model.dailyPercent < 0 {
            dailyPercentageLabel.textColor = .red
        }
    }
    
    @IBAction func didTapFavorite(_ sender: Any) {
        isFavorite.toggle()
        delegate?.didTapFavorite(pairModel: pairModel, isFavorite: isFavorite)
        toggleFavoriteButtonImage()
    }
    
    private func toggleFavoriteButtonImage() {
        DispatchQueue.main.async {
            if self.isFavorite {
                self.favoriteButtonOutlet.setImage(UIImage(systemName: "star.fill"), for: .normal)
            } else {
                self.favoriteButtonOutlet.setImage(UIImage(systemName: "star"), for: .normal)
            }
        }
    }
}
