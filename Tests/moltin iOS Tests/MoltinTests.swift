//
//  moltin_iOS_Tests.swift
//  moltin iOS Tests
//
//  Created by Craig Tweedy on 21/02/2018.
//

import XCTest

@testable
import moltin

class MoltinTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testClientIDSetup() {
        let config = MoltinConfig.default(withClientID: "12345")
        let moltin = Moltin(withClientID: "12345")
        XCTAssert(moltin.config == config)
    }
    
    func testDefaultLocale() {
        let config = MoltinConfig.default(withClientID: "12345", withLocale: Locale.current)
        let moltin = Moltin(withClientID: "12345")
        XCTAssert(moltin.config == config)
    }
    
    func testCustomLocale() {
        let locale = Locale(identifier: "fr_FR")
        let config = MoltinConfig.default(withClientID: "12345", withLocale: locale)
        let moltin = Moltin(withClientID: "12345", withConfiguration: config)
        XCTAssert(moltin.config == config)
    }
    
    func testHTTPHandlesIncorrectConfig() {
        let moltin = Moltin(withClientID: "12345")
        let session = MockURLSession()
        let http = MockedMoltinHTTP(withSession: session)
        
        XCTAssertThrowsError(try http.buildURLRequest(
            withConfiguration: moltin.config,
            withPath: "/test",
            withQueryParameters:[]
        )) { (error) -> Void in
            XCTAssertEqual(error as? MoltinError, MoltinError.unacceptableRequest)
        }
    }
    
    func testHTTPHandlesCorrectConfig() {
        let moltin = Moltin(withClientID: "12345")
        let http = MoltinHTTP(withSession: MockURLSession())
        
        let urlRequest = try? http.buildURLRequest(
            withConfiguration: moltin.config,
            withPath: "/test",
            withQueryParameters:[]
        )
        XCTAssertNotNil(urlRequest)
    }
    
    func testSingleObjectRequestHandlesNoData() {
        let moltin = Moltin(withClientID: "12345")
        let request = moltin.product
        let session = MockURLSession()
        session.nextError = MoltinError.noData
        request.http = MoltinHTTP(withSession: session)
        
        let expectationToFulfill = expectation(description: "ProductRequest calls the method and runs the callback closure")
        
        request.get(forID: "test") { (result) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error as? MoltinError, MoltinError.noData)
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
    
    func testSingleObjectRequestHandlesIncorrectConfig() {
        let moltin = Moltin(withClientID: "12345")
        let request = moltin.product
        let session = MockURLSession()
        session.nextError = MoltinError.noData
        request.http = MockedMoltinHTTP(withSession: session)
        
        let expectationToFulfill = expectation(description: "ProductRequest calls the method and runs the callback closure")
        
        request.get(forID: "test") { (result) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error as? MoltinError, MoltinError.unacceptableRequest)
            default: break
            }
            
            expectationToFulfill.fulfill()
        }
        
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    
    func testCollectionRequestHandlesIncorrectConfig() {
        let moltin = Moltin(withClientID: "12345")
        let request = moltin.product
        let session = MockURLSession()
        session.nextError = MoltinError.noData
        request.http = MockedMoltinHTTP(withSession: session)
        
        let expectationToFulfill = expectation(description: "ProductRequest calls the method and runs the callback closure")
        
        request.all { (result) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error as? MoltinError, MoltinError.unacceptableRequest)
            default: break
            }
            
            expectationToFulfill.fulfill()
        }
        
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    
    func testRequestHandlesSingleFilter() {
        let moltin = Moltin(withClientID: "12345")
        let request = moltin.product
            .filter(operator: .eq, key: "test", value: "hello")
        
        let urlRequest = try? request.http.buildURLRequest(
            withConfiguration: moltin.config,
            withPath: "/test",
            withQueryParameters:request.query.toURLQueryItems()
        )
        XCTAssertNotNil(urlRequest)
        
        let components = URLComponents(url: urlRequest!.url!, resolvingAgainstBaseURL: false)
        XCTAssertNotNil(components)
        XCTAssertNotNil(components?.query)
        XCTAssert(components!.query! == "filter=eq(test, hello)")
    }
    
    func testRequestHandlesMultipleFilter() {
        let moltin = Moltin(withClientID: "12345")
        let request = moltin.product
            .filter(operator: .eq, key: "test", value: "hello")
            .filter(operator: .eq, key: "other", value: "thing")
        
        let urlRequest = try? request.http.buildURLRequest(
            withConfiguration: moltin.config,
            withPath: "/test",
            withQueryParameters:request.query.toURLQueryItems()
        )
        XCTAssertNotNil(urlRequest)
        
        let components = URLComponents(url: urlRequest!.url!, resolvingAgainstBaseURL: false)
        XCTAssertNotNil(components)
        XCTAssertNotNil(components?.query)
        XCTAssert(components!.query! == "filter=eq(test, hello):eq(other, thing)")
    }
    
    func testRequestHandlesLimit() {
        let moltin = Moltin(withClientID: "12345")
        let request = moltin.product
            .limit(1)
        
        let urlRequest = try? request.http.buildURLRequest(
            withConfiguration: moltin.config,
            withPath: "/test",
            withQueryParameters:request.query.toURLQueryItems()
        )
        XCTAssertNotNil(urlRequest)
        
        let components = URLComponents(url: urlRequest!.url!, resolvingAgainstBaseURL: false)
        XCTAssertNotNil(components)
        XCTAssertNotNil(components?.query)
        XCTAssert(components!.query! == "limit=1")
    }
    
    func testRequestHandlesOffset() {
        let moltin = Moltin(withClientID: "12345")
        let request = moltin.product
            .offset(1)
        
        let urlRequest = try? request.http.buildURLRequest(
            withConfiguration: moltin.config,
            withPath: "/test",
            withQueryParameters:request.query.toURLQueryItems()
        )
        XCTAssertNotNil(urlRequest)
        
        let components = URLComponents(url: urlRequest!.url!, resolvingAgainstBaseURL: false)
        XCTAssertNotNil(components)
        XCTAssertNotNil(components?.query)
        XCTAssert(components!.query! == "offset=1")
    }
    
    func testRequestHandlesSort() {
        let moltin = Moltin(withClientID: "12345")
        let request = moltin.product
            .sort("test")
        
        let urlRequest = try? request.http.buildURLRequest(
            withConfiguration: moltin.config,
            withPath: "/test",
            withQueryParameters:request.query.toURLQueryItems()
        )
        XCTAssertNotNil(urlRequest)
        
        let components = URLComponents(url: urlRequest!.url!, resolvingAgainstBaseURL: false)
        XCTAssertNotNil(components)
        XCTAssertNotNil(components?.query)
        XCTAssert(components!.query! == "sort=test")
    }
    
    func testRequestHandlesSingleInclude() {
        let moltin = Moltin(withClientID: "12345")
        let request = moltin.product
            .include([.files])
        
        let urlRequest = try? request.http.buildURLRequest(
            withConfiguration: moltin.config,
            withPath: "/test",
            withQueryParameters:request.query.toURLQueryItems()
        )
        XCTAssertNotNil(urlRequest)
        
        let components = URLComponents(url: urlRequest!.url!, resolvingAgainstBaseURL: false)
        XCTAssertNotNil(components)
        XCTAssertNotNil(components?.query)
        XCTAssert(components!.query! == "includes=files")
    }
    
    func testRequestHandlesMultipleIncludes() {
        let moltin = Moltin(withClientID: "12345")
        let request = moltin.product
            .include([.files, .category])
        
        let urlRequest = try? request.http.buildURLRequest(
            withConfiguration: moltin.config,
            withPath: "/test",
            withQueryParameters:request.query.toURLQueryItems()
        )
        XCTAssertNotNil(urlRequest)
        
        let components = URLComponents(url: urlRequest!.url!, resolvingAgainstBaseURL: false)
        XCTAssertNotNil(components)
        XCTAssertNotNil(components?.query)
        XCTAssert(components!.query! == "includes=files,category")
    }
    
    func testRequestHandlesMultipleParameters() {
        let moltin = Moltin(withClientID: "12345")
        let request = moltin.product
            .include([.files, .category])
            .filter(operator: .eq, key: "test", value: "one")
            .limit(1)
            .offset(2)
            .sort("key")
        
        let urlRequest = try? request.http.buildURLRequest(
            withConfiguration: moltin.config,
            withPath: "/test",
            withQueryParameters:request.query.toURLQueryItems()
        )
        XCTAssertNotNil(urlRequest)
        
        let components = URLComponents(url: urlRequest!.url!, resolvingAgainstBaseURL: false)
        XCTAssertNotNil(components)
        XCTAssertNotNil(components?.query)
        XCTAssert(components!.query! == "includes=files,category&sort=key&limit=1&offset=2&filter=eq(test, one)")
    }
    
}
