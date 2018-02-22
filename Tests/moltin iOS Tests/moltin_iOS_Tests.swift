//
//  moltin_iOS_Tests.swift
//  moltin iOS Tests
//
//  Created by Craig Tweedy on 21/02/2018.
//

import XCTest

@testable
import moltin

class moltin_iOS_Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testClientIDSetup() {
        let moltin = Moltin(withClientID: "12345")
        XCTAssert(moltin.config.clientID == "12345")
    }
    
    func testDefaultLocale() {
        let currentLocale = Locale.current
        let moltin = Moltin(withClientID: "12345")
        XCTAssert(moltin.config.locale == currentLocale)
    }
    
    func testCustomLocale() {
        let locale = Locale(identifier: "fr_FR")
        var config = MoltinConfig.default(withClientID: "12345")
        config.locale = locale
        let moltin = Moltin(withClientID: "12345", withConfiguration: config)
        XCTAssert(moltin.config.locale == locale)
    }
    
    func testRequestHandlesCorrectConfig() {
        let moltin = Moltin(withClientID: "12345")
        let request = moltin.product
        
        let urlRequest = try? request.http.buildURLRequest(
            withConfiguration: moltin.config,
            withPath: "/test",
            withQueryParameters:request.query.toURLQueryItems()
        )
        XCTAssertNotNil(urlRequest)
    }
    
    func testRequestHandlesSingleFilter() {
        let moltin = Moltin(withClientID: "12345")
        let request = moltin.product
            .filter(operator: "eq", key: "test", value: "hello")
        
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
            .filter(operator: "eq", key: "test", value: "hello")
            .filter(operator: "eq", key: "other", value: "thing")
        
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
            .filter(operator: "eq", key: "test", value: "one")
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
