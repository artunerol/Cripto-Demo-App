//
//  PairChartVM.swift
//  Cripto-Demo
//
//  Created by Artun Erol on 23.11.2024.
//

import Foundation
import DGCharts

enum PairChartHandler {
    case networkSuccess
}

class PairChartVM {
    var selectedPair: Pair
    
    private let network = NetworkLayer()
    private var queryItems: [URLQueryItem] = []
    var dataChangeHandler: ((PairChartHandler) -> Void)?
    var lineChartData = LineChartData()
    
    init(selectedPair: Pair) {
        self.selectedPair = selectedPair
    }
    
    func fetch() {
        configureQueryItems()
        network.request(model: ChartModel.self,
                        baseURLType: .graph,
                        apiURL: .chartData,
                        queryParams: queryItems) { result in
            switch result {
            case .success(let response):
                self.generateLineData(with: response)
                self.dataChangeHandler?(.networkSuccess)
            case .failure(_):
                break
            }
        }
    }
    
    func generateLineData(with response: ChartModel) {
        var lineChartEntries: [ChartDataEntry] = []
        response.c.forEach { closeValue in
            lineChartEntries.append(ChartDataEntry(x: Double(closeValue), y: Double(closeValue)))
        }
        
        let dataSet = LineChartDataSet(entries: lineChartEntries)
        dataSet.mode = .cubicBezier
        dataSet.drawCirclesEnabled = false
        dataSet.highlightColor = .white
        dataSet.lineWidth = 1.8
        dataSet.circleRadius = 4
        dataSet.drawHorizontalHighlightIndicatorEnabled = false
        
        self.lineChartData = LineChartData(dataSet: dataSet)
    }
    
    private func configureQueryItems() {
        let fromDate = Calendar.current.date(byAdding: .day,
                                             value: -5,
                                             to: Date()) ?? Date()
        let toDate = Date().timeIntervalSince1970
        let fromDateSeconds = Int(fromDate.timeIntervalSince1970)
        
        queryItems = [
            URLQueryItem(name: "symbol", value: selectedPair.pairName),
            URLQueryItem(name: "resolution", value: "10"),
            URLQueryItem(name: "from", value: "\(String(describing: fromDateSeconds))"),
            URLQueryItem(name: "to", value: "\(Int(toDate))")
        ]
    }
}
