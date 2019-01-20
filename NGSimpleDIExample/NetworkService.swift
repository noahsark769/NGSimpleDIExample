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

protocol NetworkInterface {
    func makeRequest(url: URL, completion: @escaping (Result<Data>) -> Void)
}

class NetworkService: NetworkInterface {
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
