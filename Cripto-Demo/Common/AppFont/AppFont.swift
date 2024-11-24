//
//  AppFont.swift
//  Cripto-Demo
//
//  Created by Artun Erol on 24.11.2024.
//

import UIKit

enum AppFont {
    case header
    case description
    
    func getFont() -> UIFont {
        switch self {
        case .header:
            UIFont.systemFont(ofSize: 16, weight: .bold)
        case .description:
            UIFont.systemFont(ofSize: 12, weight: .semibold)
        }
    }
}
