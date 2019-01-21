//
//  CatService.swift
//  NGSimpleDIExample
//
//  Created by Noah Gilmore on 1/20/19.
//  Copyright © 2019 Noah Gilmore. All rights reserved.
//

import UIKit

let getCatService = SimpleDI.bind(CatServiceInterface.self) { CatService.shared }

protocol CatServiceInterface {
    func getCatImage(width: Int, height: Int, completion: @escaping (Result<UIImage>) -> Void)
}

class CatService: CatServiceInterface {
    enum CatServiceError: Error {
        case invalidImageData
    }

    static let shared = CatService()

    func getCatImage(width: Int, height: Int, completion: @escaping (Result<UIImage>) -> Void) {
        let string = "https://placekitten.com/\(width)/\(height)"
        getNetworkService().makeRequest(url: URL(string: string)!, completion: { result in
            switch result {
            case let .error(error):
                DispatchQueue.main.async {
                    completion(.error(error: error))
                }
            case let .success(data):
                guard let image = UIImage(data: data) else {
                    DispatchQueue.main.async {
                        completion(.error(error: CatServiceError.invalidImageData))
                    }
                    return
                }
                DispatchQueue.main.async {
                    completion(.success(value: image))
                }
            }
        })
    }
}
