//
//  PairChartVC.swift
//  Cripto-Demo
//
//  Created by Artun Erol on 23.11.2024.
//

import UIKit
import DGCharts

class PairChartVC: BaseViewController {
    
    private let viewModel: PairChartVM
    
    // MARK: - Outlets
    @IBOutlet weak var lineChartViewContainer: UIView!
    
    private lazy var lineChartView: LineChartView = {
        let chartView = LineChartView()
        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.xAxis.enabled = false
        chartView.leftAxis.enabled = false
        chartView.rightAxis.labelTextColor = .white
        return chartView
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        listenDataHandler()
        viewModel.fetch()
    }
    
    init(vm: PairChartVM) {
        viewModel = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func listenDataHandler() {
        toggleLoading(true)
        viewModel.dataChangeHandler = { change in
            switch change {
            case .networkSuccess:
                DispatchQueue.main.async {
                    self.lineChartView.data = self.viewModel.lineChartData
                    self.lineChartViewContainer.addSubview(self.lineChartView)
                    self.setChartViewConstraints()
                    self.toggleLoading(false)
                }
            }
        }
    }
    
    // MARK: - Helpers
    
    private func setChartViewConstraints() {
        lineChartView.leadingAnchor.constraint(equalTo: lineChartViewContainer.leadingAnchor).isActive = true
        lineChartView.trailingAnchor.constraint(equalTo: lineChartViewContainer.trailingAnchor).isActive = true
        lineChartView.topAnchor.constraint(equalTo: lineChartViewContainer.topAnchor).isActive = true
        lineChartView.bottomAnchor.constraint(equalTo: lineChartViewContainer.bottomAnchor).isActive = true
    }
    
    private func configureNavigationBar() {
        self.title = viewModel.selectedPair.pairName
        navigationController?.navigationBar.standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
}
