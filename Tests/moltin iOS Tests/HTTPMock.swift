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
                          withQueryParameters queryParams: [URLQueryItem]) -> URL? {
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
        let moltin = Moltin(withClientID: "12345")
        let productRequest = moltin.product
        let mockSession = MockURLSession()
        mockSession.nextData = json.data(using: .utf8)!
        productRequest.http = MoltinHTTP(withSession: mockSession)
        let mockAuthSession = MockURLSession()
        mockAuthSession.nextData = MockFactory.authJSON.data(using: .utf8)!
        productRequest.auth.http = MoltinHTTP(withSession: mockAuthSession)
        
        return (moltin, productRequest)
    }
}
