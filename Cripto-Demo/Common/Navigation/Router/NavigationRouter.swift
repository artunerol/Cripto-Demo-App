//
//  NavigationRouter.swift
//  Cripto-Demo
//
//  Created by Artun Erol on 23.11.2024.
//

import UIKit

class NavigationRouter {
    var baseNC: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.baseNC = navigationController
    }
    
    func navigate(toVC: NavigationEnum) {
        baseNC.present(toVC.getViewController(), animated: true)
    }
}

// MARK: - NavigationEnum & Type

enum NavigationEnum {
    // NavigationEnum is adding a control layer over ViewControllers since Enums should be exhaustive.
    case pairList
    case pairChart(vm: PairChartVM)
    
    func getViewController() -> UIViewController {
        switch self {
        case .pairList:
            PairListVC()
        case .pairChart(vm: let viewModel):
            PairChartVC(vm: viewModel)
        }
    }
}
