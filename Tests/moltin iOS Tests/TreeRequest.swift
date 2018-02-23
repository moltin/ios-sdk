//
//  TreeRequest.swift
//  moltin iOS
//
//  Created by Craig Tweedy on 23/02/2018.
//

import XCTest

@testable
import moltin

class MyBrand: Brand {
    
}

class TreeRequestTests: XCTestCase {

    let treeJson = """
        {
          "id": "51b56d92-ab99-4802-a2c1-be150848c629",
          "author": {
            "name": "Craig"
          }
        }
    """
    
    func testRequestReturnTree() {
        let (_, brandRequest) = MockFactory.mockedBrandRequest(withJSON: self.treeJson)
        
        let expectationToFulfill = expectation(description: "Request calls the method and runs the callback closure")
        
        brandRequest.tree { (result) in
            switch result {
            case .success(let response):
                let brands: [Brand]? = []
                XCTAssert(type(of: brands) == type(of: response.data))
                XCTAssert(response.data?.count != 0)
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
    
    func testRequestReturnCustomTree() {
        let (_, brandRequest) = MockFactory.mockedBrandRequest(withJSON: self.treeJson)
        
        let expectationToFulfill = expectation(description: "Request calls the method and runs the callback closure")
        
        brandRequest.tree { (result: Result<PaginatedResponse<[MyBrand]>>) in
            switch result {
            case .success(let response):
                let brands: [MyBrand]? = []
                XCTAssert(type(of: brands) == type(of: response.data))
                XCTAssert(response.data?.count != 0)
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
