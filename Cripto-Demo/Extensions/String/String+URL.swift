//
//  String+URL.swift
//  Cripto-Demo
//
//  Created by Artun Erol on 23.11.2024.
//

import Foundation

extension String {
    func convertToURL() -> URL {
        if let urlFromString = URL(string: self) {
            return urlFromString
        } else {
            // Any type of error handling can be done. Either showing a WarningView or giving a default URL is possible.
            print("Can not convert String to URL")
            return URL(fileURLWithPath: "")
        }
    }
}
