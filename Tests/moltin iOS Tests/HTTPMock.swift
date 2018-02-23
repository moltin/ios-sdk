//
//  HTTPMock.swift
//  moltin
//
//  Created by Craig Tweedy on 22/02/2018.
//

import Foundation

class MockURLSession: URLSessionProtocol {
    var nextDataTask = MockURLSessionDataTask()
    var nextData: Data?
    var nextError: Error?
    
    private (set) var lastURLRequest: URLRequest?
    
    func dataTask(with urlRequest: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        self.lastURLRequest = urlRequest
        completionHandler(self.nextData, nil, self.nextError)
        return self.nextDataTask
    }
}

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    private (set) var resumeWasCalled = false
    
    func resume() {
        self.resumeWasCalled = true
    }
}

class MockedMoltinHTTP: MoltinHTTP {
    
    override func buildURL(withConfiguration configuration: MoltinConfig,
                          withEndpoint endpoint: String,
                          withQueryParameters queryParams: [URLQueryItem],
                          includeVersion: Bool = true) -> URL? {
        return nil
    }
}


class MockFactory {
    
    static let authJSON = """
    {
        "access_token": "123asdasd123",
        "expires": 1001010
    }
    """
    
    static func mockedProductRequest(withJSON json: String) -> (Moltin, ProductRequest) {
        // Set up moltin
        let moltin = Moltin(withClientID: "12345")
        // get a product request
        let productRequest = moltin.product
        
        // mock out the product requests's api
        let mockSession = MockURLSession()
        mockSession.nextData = json.data(using: .utf8)!
        productRequest.http = MoltinHTTP(withSession: mockSession)
        
        // mock out the authentication
        let mockAuthSession = MockURLSession()
        mockAuthSession.nextData = MockFactory.authJSON.data(using: .utf8)!
        productRequest.auth.http = MoltinHTTP(withSession: mockAuthSession)
        
        return (moltin, productRequest)
    }
    
    static func mockedBrandRequest(withJSON json: String) -> (Moltin, BrandRequest) {
        let moltin = Moltin(withClientID: "12345")
        let request = moltin.brand
        let mockSession = MockURLSession()
        mockSession.nextData = json.data(using: .utf8)!
        request.http = MoltinHTTP(withSession: mockSession)
        let mockAuthSession = MockURLSession()
        mockAuthSession.nextData = MockFactory.authJSON.data(using: .utf8)!
        request.auth.http = MoltinHTTP(withSession: mockAuthSession)
        
        return (moltin, request)
    }
}
