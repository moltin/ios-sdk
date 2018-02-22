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
    let author: Author
    
    private enum CodingKeys : String, CodingKey { case author }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.author = try container.decode(Author.self, forKey: .author)
        try super.init(from: decoder)
    }
    
    internal init(withID id: String, withAuthor author: Author) {
        self.author = author
        super.init(withID: id)
    }
}

class Author: Codable, Equatable {
    let name: String
    
    init(withName name: String) {
        self.name = name
    }
    
    static func ==(lhs: Author, rhs: Author) -> Bool {
        return lhs.name == rhs.name
    }
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
        mockSession.nextData = self.multiProductJson.data(using: .utf8)!
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
        mockSession.nextData = self.productJson.data(using: .utf8)!
        productRequest.http = MoltinHTTP(withSession: mockSession)
        
        let expectationToFulfill = expectation(description: "ProductRequest calls the method and runs the callback closure")
        
        productRequest.get(forID: "51b56d92-ab99-4802-a2c1-be150848c629") { (result) in
            switch result {
            case .success(let response):
                let product = Product(withID: "51b56d92-ab99-4802-a2c1-be150848c629")
                XCTAssert(type(of: product) == type(of: response))
                XCTAssert(product.id == response.id)
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
        mockSession.nextData = self.multiProductJson.data(using: .utf8)!
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
        mockSession.nextData = self.productJson.data(using: .utf8)!
        productRequest.http = MoltinHTTP(withSession: mockSession)
        
        let expectationToFulfill = expectation(description: "ProductRequest calls the method and runs the callback closure")
        
        productRequest.get(forID: "51b56d92-ab99-4802-a2c1-be150848c629") { (result: Result<MyCustomProduct>) in
            switch result {
            case .success(let response):
                let author = Author(withName: "Craig")
                let product = MyCustomProduct(
                    withID: "51b56d92-ab99-4802-a2c1-be150848c629",
                    withAuthor: author)
                XCTAssert(type(of: product) == type(of: response))
                XCTAssert(product.id == response.id)
                XCTAssert(product.author == response.author)
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
