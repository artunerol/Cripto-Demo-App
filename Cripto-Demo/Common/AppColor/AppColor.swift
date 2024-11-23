//
//  AppColor.swift
//  Cripto-Demo
//
//  Created by Artun Erol on 23.11.2024.
//

import UIKit

enum AppColor {
    case background
    case secondaryBackground
    case textWhite
    case positiveGreen
    case negativeRed
    
    func getColor() -> UIColor {
        switch self {
        case .background:
            UIColor(red: 0.035, green: 0.062, blue: 0.105, alpha: 1)
        case .textWhite:
            UIColor(red: 0.972, green: 0.972, blue: 0.972, alpha: 1)
        case .secondaryBackground:
            UIColor(red: 0.560, green: 0.596, blue: 0.650, alpha: 1)
        case .positiveGreen:
            UIColor(red: 0, green: 0.611, blue: 0.129, alpha: 1)
        case .negativeRed:
            UIColor(red: 0.839, green: 0.188, blue: 0.117, alpha: 1)
        }
    }
}
