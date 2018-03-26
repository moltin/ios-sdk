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
    private (set) var cancelWasCalled = false
    
    func resume() {
        self.resumeWasCalled = true
    }
    
    func cancel() {
        self.cancelWasCalled = true
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

class MockedMoltinDataSerializer: DataSerializer {
    
    func serialize(_ data: Any) throws -> Data {
        throw MoltinError.couldNotSetData
    }
}

class MockObjectFactory {
    
    static func object<T: Codable>(fromJSON json: [String: Any]) -> T? {
        let decoder = JSONDecoder.dateFormattingDecoder()
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: [])
            let obj = try decoder.decode(T.self, from: data)
            return obj
        } catch {
            return nil
        }
    }
}


class MockFactory {
    
    static let authJSON = """
    {
        "access_token": "123asdasd123",
        "expires": 1001010
    }
    """
    
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
    
    static func mockedCartRequest(withJSON json: String) -> (Moltin, CartRequest) {
        let moltin = Moltin(withClientID: "12345")
        let request = moltin.cart
        let mockSession = MockURLSession()
        mockSession.nextData = json.data(using: .utf8)!
        request.http = MoltinHTTP(withSession: mockSession)
        let mockAuthSession = MockURLSession()
        mockAuthSession.nextData = MockFactory.authJSON.data(using: .utf8)!
        request.auth.http = MoltinHTTP(withSession: mockAuthSession)
        
        return (moltin, request)
    }
    
    static func mockedCollectionRequest(withJSON json: String) -> (Moltin, CollectionRequest) {
        let moltin = Moltin(withClientID: "12345")
        let request = moltin.collection
        let mockSession = MockURLSession()
        mockSession.nextData = json.data(using: .utf8)!
        request.http = MoltinHTTP(withSession: mockSession)
        let mockAuthSession = MockURLSession()
        mockAuthSession.nextData = MockFactory.authJSON.data(using: .utf8)!
        request.auth.http = MoltinHTTP(withSession: mockAuthSession)
        
        return (moltin, request)
    }
    
    static func mockedCurrencyRequest(withJSON json: String) -> (Moltin, CurrencyRequest) {
        let moltin = Moltin(withClientID: "12345")
        let request = moltin.currency
        let mockSession = MockURLSession()
        mockSession.nextData = json.data(using: .utf8)!
        request.http = MoltinHTTP(withSession: mockSession)
        let mockAuthSession = MockURLSession()
        mockAuthSession.nextData = MockFactory.authJSON.data(using: .utf8)!
        request.auth.http = MoltinHTTP(withSession: mockAuthSession)
        
        return (moltin, request)
    }
    
    static func mockedFileRequest(withJSON json: String) -> (Moltin, FileRequest) {
        let moltin = Moltin(withClientID: "12345")
        let request = moltin.file
        let mockSession = MockURLSession()
        mockSession.nextData = json.data(using: .utf8)!
        request.http = MoltinHTTP(withSession: mockSession)
        let mockAuthSession = MockURLSession()
        mockAuthSession.nextData = MockFactory.authJSON.data(using: .utf8)!
        request.auth.http = MoltinHTTP(withSession: mockAuthSession)
        
        return (moltin, request)
    }
    
    static func mockedFieldRequest(withJSON json: String) -> (Moltin, FieldRequest) {
        let moltin = Moltin(withClientID: "12345")
        let request = moltin.field
        let mockSession = MockURLSession()
        mockSession.nextData = json.data(using: .utf8)!
        request.http = MoltinHTTP(withSession: mockSession)
        let mockAuthSession = MockURLSession()
        mockAuthSession.nextData = MockFactory.authJSON.data(using: .utf8)!
        request.auth.http = MoltinHTTP(withSession: mockAuthSession)
        
        return (moltin, request)
    }
    
    static func mockedFlowRequest(withJSON json: String) -> (Moltin, FlowRequest) {
        let moltin = Moltin(withClientID: "12345")
        let request = moltin.flow
        let mockSession = MockURLSession()
        mockSession.nextData = json.data(using: .utf8)!
        request.http = MoltinHTTP(withSession: mockSession)
        let mockAuthSession = MockURLSession()
        mockAuthSession.nextData = MockFactory.authJSON.data(using: .utf8)!
        request.auth.http = MoltinHTTP(withSession: mockAuthSession)
        
        return (moltin, request)
    }
    
    static func mockedCategoryRequest(withJSON json: String) -> (Moltin, CategoryRequest) {
        let moltin = Moltin(withClientID: "12345")
        let request = moltin.category
        let mockSession = MockURLSession()
        mockSession.nextData = json.data(using: .utf8)!
        request.http = MoltinHTTP(withSession: mockSession)
        let mockAuthSession = MockURLSession()
        mockAuthSession.nextData = MockFactory.authJSON.data(using: .utf8)!
        request.auth.http = MoltinHTTP(withSession: mockAuthSession)
        
        return (moltin, request)
    }
    
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
    
    
}
