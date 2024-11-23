//
//  FavoritePairsCollectionViewCell.swift
//  Cripto-Demo
//
//  Created by Artun Erol on 23.11.2024.
//

import UIKit

class FavoritePairsCollectionViewCell: UICollectionViewCell {
    static let identifier = "FavoritePairsCollectionViewCell"
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.backgroundColor = AppColor.secondaryBackground.getColor()
    }

}
