//
//  UIView+Nibname.swift
//  Cripto-Demo
//
//  Created by Artun Erol on 23.11.2024.
//

import UIKit

extension UIView {
    static func getNibName() -> String {
        String(describing: self)
    }
}
