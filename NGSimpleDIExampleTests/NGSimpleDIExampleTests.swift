//
//  NGSimpleDIExampleTests.swift
//  NGSimpleDIExampleTests
//
//  Created by Noah Gilmore on 1/20/19.
//  Copyright © 2019 Noah Gilmore. All rights reserved.
//

import XCTest
@testable import NGSimpleDIExample

class NetworkThatAlwaysErrors: NetworkInterface {
    func makeRequest(url: URL, completion: @escaping (Result<Data>) -> Void) {
        completion(.error(error: NSError(domain: "", code: 0, userInfo: nil)))
    }
}

class NGSimpleDIExampleTests: XCTestCase {
    func testCatServiceReportsError() {
        SimpleDI.isTestEnvironment = true
        SimpleDI.mock(NetworkInterface.self) { NetworkThatAlwaysErrors() }

        let expecation = self.expectation(description: "Should return error")
        let service = CatService()
        service.getCatImage(width: 100, height: 200, completion: { result in
            if case .error = result {
                expecation.fulfill()
            }
        })
        self.waitForExpectations(timeout: 0.2)
    }
}
