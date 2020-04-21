//
//  DictionaryData.swift
//  Final Project
//
//  Created by 张泽华 on 2020/4/21.
//  Copyright © 2020 张泽华. All rights reserved.
//

import Foundation

public class SwiftOxfordAPI {
    
    public static let shared = SwiftOxfordAPI()
    
    private struct API {
        static let base = "https://od-api.oxforddictionaries.com/api/v2"
        
        struct entries {
            static let base = "entries"
            static let method = "GET"
            static let url = API.base + "/" + entries.base
        }
    }
    
    private var appId = "d068abad"
    private var appKey =  "68e38766d0409e0ca71fa2bbb96d466b"
    private let session = URLSession(configuration: .default)
    
    
    public typealias RequestHandler = ((_ data: [String: Any]?, _ error: Error?) -> Void)
    

    public func start(appId: String, appKey: String) {
        self.appId = appId
        self.appKey = appKey
    }
    

    public func entries(language: String, word: String, region: String? = nil, filters: String? = nil, _ completion: @escaping RequestHandler) {
        var urlString = API.entries.url + "/" + language + "/" + word.lowercased()
        if let region = region {
            urlString += "/regions=\(region)"
        }
        if let filters = filters {
            urlString += ((region != nil ? ";" : "/") + filters)
        }
        performRequest(withURL: urlString, httpMethod: API.entries.method, completion)
    }

    private func performRequest(withURL urlString: String, httpMethod: String, _ completion: @escaping RequestHandler) {
        guard let urlComponents = URLComponents(string: urlString) else {
            completion(nil, nil)
            return
        }
        
        guard let url = urlComponents.url else {
            completion(nil, nil)
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue(appId, forHTTPHeaderField: "app_id")
        urlRequest.addValue(appKey, forHTTPHeaderField: "app_key")
        urlRequest.httpMethod = httpMethod
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                (200 ..< 300) ~= response.statusCode,
                error == nil else {
                    completion(nil, error)
                    return
            }
            
            guard let object = (try? JSONSerialization.jsonObject(with: data)) as? [String: Any] else {
                completion(nil, error)
                return
            }
            
            completion(object, nil)
        }
        task.resume()
    }
    
}
