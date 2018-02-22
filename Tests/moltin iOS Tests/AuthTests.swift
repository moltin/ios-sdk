//
//  AuthTests.swift
//  moltin
//
//  Created by Craig Tweedy on 22/02/2018.
//

import XCTest

@testable
import moltin

class AuthRequestTests: XCTestCase {
    
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

    let authJson = """
    {
        "access_token": "123asdasd123",
        "expires": 1001010
    }
    """
    
    func testAuthAuthenticatesSuccessfullyAndPassesThrough() {
        let (_, productRequest) = MockFactory.mockedProductRequest(withJSON: self.multiProductJson)
        
        let expectationToFulfill = expectation(description: "ProductRequest calls the method and runs the callback closure")
        
        productRequest.all { (result) in
            switch result {
            case .success(_):
                XCTAssertTrue(true)
                break
            case .failure(_):
                XCTFail("Could not authenticate")
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
    
    func testAuthAuthenticatesFailsCorrectly() {
        let (_, productRequest) = MockFactory.mockedProductRequest(withJSON: self.multiProductJson)
        let mockSession = MockURLSession()
        productRequest.auth.http = MoltinHTTP(withSession: mockSession)
        
        let expectationToFulfill = expectation(description: "ProductRequest calls the method and runs the callback closure")
        
        productRequest.all { (result) in
            switch result {
            case .success(_):
                XCTFail()
                break
            case .failure(let error):
                XCTAssertNotNil(error)
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
