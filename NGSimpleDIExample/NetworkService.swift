//
//  NetworkService.swift
//  NGSimpleDIExample
//
//  Created by Noah Gilmore on 1/20/19.
//  Copyright © 2019 Noah Gilmore. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(value: T)
    case error(error: Error)
}

let getNetworkService = SimpleDI.bind(NetworkInterface.self) { NetworkService.shared }

protocol NetworkInterface {
    func makeRequest(url: URL, completion: @escaping (Result<Data>) -> Void)
}

private class NetworkService: NetworkInterface {
    static let shared = NetworkService()

    func makeRequest(url: URL, completion: @escaping (Result<Data>) -> Void) {
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            if let error = error {
                completion(.error(error: error))
            } else {
                guard let data = data else { return }
                completion(.success(value: data))
            }
        })
        task.resume()
    }
}
