//
//  SimpleDI.swift
//  NGSimpleDIExample
//
//  Created by Noah Gilmore on 1/20/19.
//  Copyright © 2019 Noah Gilmore. All rights reserved.
//

import Foundation

private var typeToImplementation: [String: Any] = [:]
private var mockTypeToImplementation: [String: Any] = [:]

enum SimpleDI {
    static var isTestEnvironment = false

    static func bind<T>(_ interfaceType: T.Type, accessor: () -> T) -> () -> T {
        let key = String(describing: interfaceType)
        typeToImplementation[key] = accessor()
        return {
            if SimpleDI.isTestEnvironment {
                guard let mockedImplementation = mockTypeToImplementation[key] as? T else {
                    fatalError("Type \(key) unmocked in test!")
                }
                return mockedImplementation
            }
            return typeToImplementation[key] as! T
        }
    }

    static func mock<T>(_ interfaceType: T.Type, _ mockImplementation: T) {
        mockTypeToImplementation[String(describing: interfaceType)] = mockImplementation
    }
}
