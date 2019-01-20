//
//  CatService.swift
//  NGSimpleDIExample
//
//  Created by Noah Gilmore on 1/20/19.
//  Copyright © 2019 Noah Gilmore. All rights reserved.
//

import UIKit

protocol CatServiceInterface {
    func getCatImage(width: Int, height: Int, completion: @escaping (Result<UIImage>) -> Void)
}

class CatService: CatServiceInterface {
    enum CatServiceError: Error {
        case invalidImageData
    }

    func getCatImage(width: Int, height: Int, completion: @escaping (Result<UIImage>) -> Void) {
        // HERE
        let string = "https://placekitten.com/\(width)/\(height)"
        print(string)
        NetworkService().makeRequest(url: URL(string: string)!, completion: { result in
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
