import Foundation
import OHHTTPStubs

class Stub {
    static let stubbedURL_doNotChange: String = "https://www.address-does-not-matter.com"
    
    var json: Any? {
        guard let path = Bundle(for: type(of: self)).path(forResource: "ratings", ofType: "json") else {
            return nil
        }
        
        if let jsonData = NSData(contentsOfFile: path) {
            do {
                let jsonResult = try JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions(rawValue: UInt(0)))
                return jsonResult
            }
            catch {
                assertionFailure("Failed to build json for \(path) error: \(error)")
            }
        }
        
        return nil
    }
    
    var responseData: Data? {
        do {
            let data = try JSONSerialization.data(withJSONObject: self.json!, options: JSONSerialization.WritingOptions(rawValue: 0))
            return data
        }
        catch {
            assertionFailure("Failed to build \(String(describing: self.json)) response data: \(error)")
            return nil
        }
    }
    
    let requestTime: TimeInterval = {
        return 0.01
    }()
    
    let responseTime: TimeInterval = {
        return 1.0
    }()
    
    var responseObject: HTTPStubsResponse {
        var response: HTTPStubsResponse
        
        if let responseData = self.responseData {
            response = HTTPStubsResponse(data: responseData, statusCode: 200, headers: self.responseHeaders)
        }
        else {
            // create an error and return it
            let error = NSError(domain: "RecommendationsError", code: 500, userInfo: nil)
            response = HTTPStubsResponse(error: error as Error)
        }
        
        return response.requestTime(self.requestTime, responseTime: self.responseTime)
    }
    
    class func clearAll() {
        HTTPStubs.removeAllStubs()
    }
    
    func registerStub() {
        HTTPStubs.stubRequests(passingTest: { request -> Bool in
            return request.url?.absoluteString.range(of: Stub.stubbedURL_doNotChange) != nil
        }, withStubResponse: { request in
            let response = self.responseObject
            return response
        })
    }
    
    var responseHeaders: [String: Any] {
        return [
            "Content-Type": "application/json"
        ]
    }
}
