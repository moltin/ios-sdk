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
            withQueryParameters: []
        )) { (error) -> Void in
            if case MoltinError.unacceptableRequest = error {} else {
                XCTAssertTrue(false, "error")
            }
        }
    }

    func testHTTPHandlesCorrectConfig() {
        let moltin = Moltin(withClientID: "12345")
        let http = MoltinHTTP(withSession: MockURLSession())

        let urlRequest = try? http.buildURLRequest(
            withConfiguration: moltin.config,
            withPath: "/test",
            withQueryParameters: []
        )
        XCTAssertNotNil(urlRequest)
    }

    func testSingleObjectRequestHandlesNoData() {
        let moltin = Moltin(withClientID: "12345")
        let request = moltin.product
        let session = MockURLSession()
        session.nextError = MoltinError.noData
        request.http = MoltinHTTP(withSession: session)
        let authSession = MockURLSession()
        authSession.nextData = MockFactory.authJSON.data(using: .utf8)!
        request.auth.http = MoltinHTTP(withSession: authSession)

        let expectationToFulfill = expectation(description: "ProductRequest calls the method and runs the callback closure")

        _ = request.get(forID: "test") { (result) in
            switch result {
            case .failure(let error):
                if case MoltinError.responseError = error {} else {
                    XCTAssertTrue(false, "error")
                }
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

        _ = request.get(forID: "test") { (result) in
            switch result {
            case .failure(let error):
                if case MoltinError.unacceptableRequest = error {} else {
                    XCTAssertTrue(false, "error")
                }
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

        _ = request.all { (result) in
            switch result {
            case .failure(let error):
                if case MoltinError.unacceptableRequest = error {} else {
                    XCTAssertTrue(false, "error")
                }
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
            .filter(operator: .equal, key: "test", value: "hello")

        let urlRequest = try? request.http.buildURLRequest(
            withConfiguration: moltin.config,
            withPath: "/test",
            withQueryParameters: request.query.toURLQueryItems()
        )
        XCTAssertNotNil(urlRequest)

        let components = URLComponents(url: urlRequest!.url!, resolvingAgainstBaseURL: false)
        XCTAssertNotNil(components)
        XCTAssertNotNil(components?.query)
        XCTAssert(components!.query! == "filter=eq(test,hello)")
    }

    func testRequestHandlesMultipleFilter() {
        let moltin = Moltin(withClientID: "12345")
        let request = moltin.product
            .filter(operator: .equal, key: "test", value: "hello")
            .filter(operator: .equal, key: "other", value: "thing")

        let urlRequest = try? request.http.buildURLRequest(
            withConfiguration: moltin.config,
            withPath: "/test",
            withQueryParameters: request.query.toURLQueryItems()
        )
        XCTAssertNotNil(urlRequest)

        let components = URLComponents(url: urlRequest!.url!, resolvingAgainstBaseURL: false)
        XCTAssertNotNil(components)
        XCTAssertNotNil(components?.query)
        XCTAssert(components!.query! == "filter=eq(test,hello):eq(other,thing)")
    }

    func testRequestHandlesLimit() {
        let moltin = Moltin(withClientID: "12345")
        let request = moltin.product
            .limit(1)

        let urlRequest = try? request.http.buildURLRequest(
            withConfiguration: moltin.config,
            withPath: "/test",
            withQueryParameters: request.query.toURLQueryItems()
        )
        XCTAssertNotNil(urlRequest)

        let components = URLComponents(url: urlRequest!.url!, resolvingAgainstBaseURL: false)
        XCTAssertNotNil(components)
        XCTAssertNotNil(components?.query)
        XCTAssert(components!.query! == "page[limit]=1")
    }

    func testRequestHandlesOffset() {
        let moltin = Moltin(withClientID: "12345")
        let request = moltin.product
            .offset(1)

        let urlRequest = try? request.http.buildURLRequest(
            withConfiguration: moltin.config,
            withPath: "/test",
            withQueryParameters: request.query.toURLQueryItems()
        )
        XCTAssertNotNil(urlRequest)

        let components = URLComponents(url: urlRequest!.url!, resolvingAgainstBaseURL: false)
        XCTAssertNotNil(components)
        XCTAssertNotNil(components?.query)
        XCTAssert(components!.query! == "page[offset]=1")
    }

    func testRequestHandlesSort() {
        let moltin = Moltin(withClientID: "12345")
        let request = moltin.product
            .sort("test")

        let urlRequest = try? request.http.buildURLRequest(
            withConfiguration: moltin.config,
            withPath: "/test",
            withQueryParameters: request.query.toURLQueryItems()
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
            withQueryParameters: request.query.toURLQueryItems()
        )
        XCTAssertNotNil(urlRequest)

        let components = URLComponents(url: urlRequest!.url!, resolvingAgainstBaseURL: false)
        XCTAssertNotNil(components)
        XCTAssertNotNil(components?.query)

        XCTAssert(components!.query! == "include=files")
    }

    func testRequestHandlesMultipleIncludes() {
        let moltin = Moltin(withClientID: "12345")
        let request = moltin.product
            .include([.files, .categories])

        let urlRequest = try? request.http.buildURLRequest(
            withConfiguration: moltin.config,
            withPath: "/test",
            withQueryParameters: request.query.toURLQueryItems()
        )
        XCTAssertNotNil(urlRequest)

        let components = URLComponents(url: urlRequest!.url!, resolvingAgainstBaseURL: false)
        XCTAssertNotNil(components)
        XCTAssertNotNil(components?.query)
        XCTAssert(components!.query! == "include=files,categories")
    }

    func testRequestHandlesMultipleParameters() {
        let moltin = Moltin(withClientID: "12345")
        let request = moltin.product
            .include([.files, .categories])
            .filter(operator: .equal, key: "test", value: "one")
            .limit(1)
            .offset(2)
            .sort("key")

        let urlRequest = try? request.http.buildURLRequest(
            withConfiguration: moltin.config,
            withPath: "/test",
            withQueryParameters: request.query.toURLQueryItems()
        )
        XCTAssertNotNil(urlRequest)

        let components = URLComponents(url: urlRequest!.url!, resolvingAgainstBaseURL: false)
        XCTAssertNotNil(components)
        XCTAssertNotNil(components?.query)
        XCTAssert(components!.query! == "include=files,categories&sort=key&page[limit]=1&page[offset]=2&filter=eq(test,one)")
    }

    func testRequestHandlesNoData() {
        let moltin = Moltin(withClientID: "12345")
        let http = MoltinHTTP(withSession: MockURLSession())

        let urlRequest = try? http.buildURLRequest(
            withConfiguration: moltin.config,
            withPath: "/test",
            withQueryParameters: []
        )
        XCTAssertNotNil(urlRequest)
        XCTAssertNil(urlRequest?.httpBody)
    }

    func testRequestHandlesMalformedData() {
        let moltin = Moltin(withClientID: "12345")
        let http = MoltinHTTP(withSession: MockURLSession(), withSerializer: MockedMoltinDataSerializer())

        XCTAssertThrowsError(try http.buildURLRequest(
            withConfiguration: moltin.config,
            withPath: "/test",
            withQueryParameters: [],
            withMethod: .GET,
            withData: [:]
        )) { (error) -> Void in
            if case MoltinError.couldNotSetData = error {} else {
                XCTAssertTrue(false, "error")
            }
        }
    }

    func testMissingRequest() {
        let http = MoltinHTTP(withSession: MockURLSession())
        let completionHandler: HTTPRequestHandler = { (data, response, error) in
            if error == nil {
               XCTFail()
            }
            if case .unacceptableRequest? = error as? MoltinError {} else {
                XCTAssertTrue(false, "error")
            }
        }

        http.executeRequest(nil, completionHandler: completionHandler)

    }

    func testEmptyLocaleSettings() {
        let locale = Locale(identifier: "")
        let config = MoltinConfig.default(withClientID: "12345", withLocale: locale)
        let http = MoltinHTTP(withSession: MockURLSession())
        if let urlRequest = try? http.buildURLRequest(
            withConfiguration: config,
            withPath: "/test",
            withQueryParameters: [],
            withMethod: .GET,
            withData: [:]
            ) {
            let request = http.configureRequest(urlRequest, withToken: nil, withConfig: config)
            XCTAssertNil(request.allHTTPHeaderFields?["X-MOLTIN-LANGUAGE"])
            XCTAssertNil(request.allHTTPHeaderFields?["X-MOLTIN-CURRENCY"])
        } else {
            XCTFail()
        }
    }

    func testMalformedDataParser() {
        let parser = MoltinParser(withDecoder: JSONDecoder.dateFormattingDecoder())
        let malformedData = "{'akjsdkla}".data(using: .utf8)!

        parser.singleObjectHandler(withData: malformedData, withResponse: nil) { (result: Result<Product>) in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                if case MoltinError.couldNotParseData(_) = error {} else {
                    XCTAssertTrue(false, "error")
                }
            }
        }

        parser.collectionHandler(withData: malformedData, withResponse: nil) { (result: Result<PaginatedResponse<Product>>) in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                if case MoltinError.couldNotParseData(_) = error {} else {
                    XCTAssertTrue(false, "error")
                }
            }
        }
    }

    func testParamsAreNotShared() {
        let moltin = Moltin(withClientID: "12345")
        var request = moltin.product
            .include([.files, .categories])
            .filter(operator: .equal, key: "test", value: "one")
            .limit(1)
            .offset(2)
            .sort("key")

        let urlRequest = try? request.http.buildURLRequest(
            withConfiguration: moltin.config,
            withPath: "/test",
            withQueryParameters: request.query.toURLQueryItems()
        )
        XCTAssertNotNil(urlRequest)

        let components = URLComponents(url: urlRequest!.url!, resolvingAgainstBaseURL: false)
        XCTAssertNotNil(components)
        XCTAssertNotNil(components?.query)
        XCTAssert(components!.query! == "include=files,categories&sort=key&page[limit]=1&page[offset]=2&filter=eq(test,one)")

        request = moltin.product.limit(5).offset(8)
        let secondUrlRequest = try? request.http.buildURLRequest(
            withConfiguration: moltin.config,
            withPath: "/test",
            withQueryParameters: request.query.toURLQueryItems()
        )
        XCTAssertNotNil(urlRequest)

        let secondComponents = URLComponents(url: secondUrlRequest!.url!, resolvingAgainstBaseURL: false)
        XCTAssertNotNil(secondComponents)
        XCTAssertNotNil(secondComponents?.query)

        XCTAssert(secondComponents!.query! == "page[limit]=5&page[offset]=8")
    }

}
