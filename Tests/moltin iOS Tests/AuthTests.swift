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

    let validAuthJson = """
    {
        "access_token": "123asdasd123",
        "expires": 99999999999999999999
    }
    """

    func testAuthAuthenticatesSuccessfullyAndPassesThrough() {
        let (_, productRequest) = MockFactory.mockedProductRequest(withJSON: MockProductDataFactory.multiProductData)

        let expectationToFulfill = expectation(description: "ProductRequest calls the method and runs the callback closure")

        _ = productRequest.all { (result) in
            switch result {
            case .success(_):
                XCTAssertTrue(true)
                break
            case .failure(let error):
                if let error = error as? MoltinError {
                    XCTFail(error.localizedDescription)
                } else {
                    XCTFail(error.localizedDescription)
                }
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

        _ = productRequest.all { (result) in
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

    func testAuthTokenRefreshRequired() {
        let auth = MoltinAuth(withConfiguration: MoltinConfig.default(withClientID: "12345"))
        auth.credentials = nil

        let mockAuthSession = MockURLSession()
        auth.http = MoltinHTTP(withSession: mockAuthSession)

        let expectationToFulfill = expectation(description: "Auth calls the method and runs the callback closure")

        auth.authenticate { (result) in
            switch result {
            case .success(_):
                XCTFail()
            default: XCTAssertTrue(true)
            }

            expectationToFulfill.fulfill()
        }

        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }

    func testAuthCouldNotConfigure() {
        let auth = MoltinAuth(withConfiguration: MoltinConfig.default(withClientID: "12345"))
        auth.credentials = nil
        let mockAuthSession = MockURLSession()
        auth.http = MoltinHTTP(withSession: mockAuthSession)

        let expectationToFulfill = expectation(description: "Auth calls the method and runs the callback closure")

        auth.authenticate { (result) in
            switch result {
            case .success(_):
                XCTFail()
            default: XCTAssertTrue(true)
            }

            expectationToFulfill.fulfill()
        }

        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }

    func testAuthenticationFailed() {
        let auth = MoltinAuth(withConfiguration: MoltinConfig.default(withClientID: "12345"))
        auth.credentials = nil
        let session = MockURLSession()
        session.nextError = MoltinError.couldNotAuthenticate
        auth.http = MoltinHTTP(withSession: session)

        let expectationToFulfill = expectation(description: "Auth calls the method and runs the callback closure")

        auth.authenticate { (result) in
            switch result {
            case .success(_):
                XCTFail()
            default: XCTAssertTrue(true)
            }

            expectationToFulfill.fulfill()
        }

        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }

    func testAuthTokenNoRefreshRequired() {
        let auth = MoltinAuth(withConfiguration: MoltinConfig.default(withClientID: "12345"))
        
        auth.credentials = MoltinAuthCredentials(clientID: "12345", token: "12345", expires: Date().addingTimeInterval(10000))

        let session = MockURLSession()
        auth.http = MoltinHTTP(withSession: session)

        let expectationToFulfill = expectation(description: "Auth calls the method and runs the callback closure")

        auth.authenticate { (result) in
            switch result {
            case .success(let response):
                XCTAssert(response.token == auth.credentials?.token)
            default: XCTFail()
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
