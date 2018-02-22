//
//  ProductRequestTests.swift
//  moltin iOS Tests
//
//  Created by Craig Tweedy on 21/02/2018.
//

import XCTest

@testable
import moltin

class MyCustomProduct: Product {
    
}

class ProductRequestTests: XCTestCase {
    
    let productJson = """
                {
                  "id": "51b56d92-ab99-4802-a2c1-be150848c629",
                  "author": {
                    "name": "Craig"
                  }
                }
                """
    
    let multiProductJson = """
                {
                  "data":
                    [{
                      "id": "51b56d92-ab99-4802-a2c1-be150848c629",
                      "author": {
                        "name": "Craig"
                      }
                    }],
                    "meta": {
                    }
                }
                """

    func testProductRequestReturnsProducts() {
        let moltin = Moltin(withClientID: "12345")
        let productRequest = moltin.product
        let mockSession = MockURLSession()
        mockSession.nextData = multiProductJson.data(using: .utf8)!
        productRequest.http = MoltinHTTP(withSession: mockSession)
        
        let expectationToFulfill = expectation(description: "ProductRequest calls the method and runs the callback closure")
        
        productRequest.all { (result) in
            switch result {
            case .success(let response):
                let products: [Product]? = []
                XCTAssert(type(of: response.data) == type(of: products))
                break
            case .failure(_):
                XCTFail("Response returned error")
                break
            }
            
            expectationToFulfill.fulfill()
        }
        
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    
    func testProductRequestReturnSingleProduct() {
        let moltin = Moltin(withClientID: "12345")
        let productRequest = moltin.product
        let mockSession = MockURLSession()
        mockSession.nextData = multiProductJson.data(using: .utf8)!
        productRequest.http = MoltinHTTP(withSession: mockSession)
        
        let expectationToFulfill = expectation(description: "ProductRequest calls the method and runs the callback closure")
        
        productRequest.get(forID: "12345") { (result) in
            switch result {
            case .success(let response):
                let product = Product()
                XCTAssert(type(of: product) == type(of: response))
                break
            case .failure(_):
                XCTFail("Response returned error")
                break
            }
            
            expectationToFulfill.fulfill()
        }
        
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    
    func testProductRequestReturnsCustomProducts() {
        let moltin = Moltin(withClientID: "12345")
        let productRequest = moltin.product
        let mockSession = MockURLSession()
        mockSession.nextData = multiProductJson.data(using: .utf8)!
        productRequest.http = MoltinHTTP(withSession: mockSession)
        
        let expectationToFulfill = expectation(description: "ProductRequest calls the method and runs the callback closure")
        
        productRequest.all { (result: Result<PaginatedResponse<[MyCustomProduct]>>) in
            switch result {
            case .success(let response):
                let products: [MyCustomProduct]? = []
                XCTAssert(type(of: response.data) == type(of: products))
                break
            case .failure(_):
                XCTFail("Response returned error")
                break
            }
            
            expectationToFulfill.fulfill()
        }
        
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    
    func testProductRequestReturnCustomSingleProduct() {
        let moltin = Moltin(withClientID: "12345")
        let productRequest = moltin.product
        let mockSession = MockURLSession()
        mockSession.nextData = multiProductJson.data(using: .utf8)!
        productRequest.http = MoltinHTTP(withSession: mockSession)
        
        let expectationToFulfill = expectation(description: "ProductRequest calls the method and runs the callback closure")
        
        productRequest.get(forID: "12345") { (result: Result<MyCustomProduct>) in
            switch result {
            case .success(let response):
                let product = MyCustomProduct()
                XCTAssert(type(of: product) == type(of: response))
                break
            case .failure(_):
                XCTFail("Response returned error")
                break
            }
            
            expectationToFulfill.fulfill()
        }
        
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
}
