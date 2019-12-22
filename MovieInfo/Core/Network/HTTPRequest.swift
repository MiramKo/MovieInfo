//
//  HTTPRequest.swift
//  MovieInfo
//
//  Created by Михаил Костров on 14/11/2019.
//  Copyright © 2019 Михаил Костров. All rights reserved.
//


//TODO - errors
import Foundation

class HTTPRequest {
    
    static func request<T: LosslessStringConvertible>(url: String, parameters: [String: T], method: String, completion: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ())
    {
        let queue = DispatchQueue.global(qos: .background)
        
        queue.async {
            
            var requestURL: URL

            if !parameters.isEmpty {
                let parameterString = self.stringFrom(parameters: parameters)
                requestURL = URL(string: "\(url)?\(parameterString)")!
            } else {
                requestURL = URL(string: url)!
            }

            var request = URLRequest(url: requestURL)
            request.httpMethod = method
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if error != nil{
                    completion(nil, nil, error)
                }else{
                    completion(data, response, nil)
                }
            }
            task.resume()
        }
    }
    
    private static func stringFrom<T: LosslessStringConvertible>(parameters: [String:T]) -> String {
        let parameterArray = parameters.map { (key, value) -> String in
            let percentEscapedKey = String(key).stringByAddingPercentEncodingForURLQueryValue()
            let percentEscapedValue = String(value).stringByAddingPercentEncodingForURLQueryValue()
            return "\(percentEscapedKey ?? "")=\(percentEscapedValue ?? "")"
        }
        
        return parameterArray.joined(separator: "&")
    }
}
