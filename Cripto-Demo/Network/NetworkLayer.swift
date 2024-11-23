//
//  NetworkLayer.swift
//  Cripto-Demo
//
//  Created by Artun Erol on 23.11.2024.
//

import Foundation

enum CustomError: Error {
    case requestError(error: Error)
    case throwError
    case defaultError
}

class NetworkLayer {
    private let baseURL = "https://api.btcturk.com"
    private let graphBaseURL = "https://graph-api.btcturk.com"
    
    func request<T: Codable>(model: T.Type,
                             baseURLType: BaseURLType = .regular,
                             apiURL: ApiURLs,
                             completion: @escaping (Result<T, CustomError>) -> Void) {
        var urlString = ""
        
        switch baseURLType {
        case .regular:
            urlString = baseURL + apiURL.getURLString()
        case .graph:
            urlString = graphBaseURL + apiURL.getURLString()
        }

        var request = URLRequest(url: urlString.convertToURL())
        
        URLSession.shared.dataTask(with: request) {data, _, error in
            guard let data = data else { return }
            
            if let error = error {
                completion(.failure(.requestError(error: error)))
            }
            
            if let dataResponse = try? JSONDecoder().decode(model, from: data) {
                completion(.success(dataResponse))
            } else {
                completion(.failure(.throwError))
            }
        }.resume()
    }
}

enum BaseURLType {
    case regular
    case graph
}

enum ApiURLs {
    case pairList
    case chartData
    
    func getURLString() -> String {
        switch self {
        case .pairList:
            return "/api/v2/ticker"
        case .chartData:
            return "/v1/klines/history"
        }
    }
}
