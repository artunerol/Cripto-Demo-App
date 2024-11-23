//
//  AppNavigationController.swift
//  Cripto-Demo
//
//  Created by Artun Erol on 23.11.2024.
//

import UIKit

class AppNavigationController: UINavigationController {
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        setupNavigationController()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helpers

extension AppNavigationController {
    private func setupNavigationController() {
        let barAppearance = UINavigationBarAppearance()

        navigationBar.backIndicatorImage = UIImage(systemName: "arrow.left")
        navigationBar.backIndicatorTransitionMaskImage = UIImage(systemName: "arrow.left")
        navigationBar.backgroundColor = .clear
        navigationBar.standardAppearance = barAppearance
    }
}
