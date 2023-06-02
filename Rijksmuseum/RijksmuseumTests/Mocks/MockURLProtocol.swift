//
//  MockURLProtocol.swift
//  RijksmuseumTests
//
//  Created by Troian on 01.06.2023.
//

import Foundation

public class MockURLProtocol: URLProtocol {
    static var mockData = [String: Data]()
    
    public override class func canInit(with task: URLSessionTask) -> Bool {
        return true
    }
    
    public override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    public override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    public override func startLoading() {
        if let url = request.url {
            let path: String
            if let queryString = url.query {
                path = url.relativePath + "?" + queryString
            } else {
                path = url.relativePath
            }
            guard let data = MockURLProtocol.mockData[path] else {fatalError("data doesn't exist")}
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocol(self, didReceive: HTTPURLResponse(), cacheStoragePolicy: .allowed)
        }
        client?.urlProtocolDidFinishLoading(self)
    }
    
    public override func stopLoading() {}
}
