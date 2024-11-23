//
//  BaseViewController.swift
//  Cripto-Demo
//
//  Created by Artun Erol on 23.11.2024.
//

import UIKit

class BaseViewController: UIViewController {
    var navigationRouter: NavigationRouter {
        get {
            return NavigationRouter(navigationController: self.navigationController ?? UINavigationController())
        }
    }
    
    private var spinner = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = AppColor.background.getColor()
        view.addSubview(spinner)
        setupSpinner()
    }
    
    private func setupSpinner() {
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        spinner.color = .white
        spinner.style = .large
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

// MARK: - LoadingStatus

extension BaseViewController {
    func toggleLoading(_ toggle: Bool) {
        if toggle {
            spinner.startAnimating()
        } else {
            spinner.stopAnimating()
        }
    }
}
