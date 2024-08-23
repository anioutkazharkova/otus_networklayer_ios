//
//  NetworkService.swift
//  iosApp
//
//  Created by Anna Zharkova on 23.08.2024.
//  Copyright © 2024 orgName. All rights reserved.
//

import Foundation

enum Method : String {
    case get = "GET"
    case post = "POST"
}

class CustomError : Error {
    let message: String
    
    init(message: String) {
        self.message = message
    }
}

class NetworkService {
    private let networkConfiguration: NetworkConfiguration
    
    private lazy var urlSession: URLSession = {
        return URLSession(configuration: .default)
    }()
    
    private var dataTask: URLSessionDataTask? = nil
    private let jsonDecoder = JSONDecoder()
    
    init(networkConfiguration: NetworkConfiguration) {
        self.networkConfiguration = networkConfiguration
    }
    
    
    func request<T:Codable>(path: String, method: Method, completion: @escaping(Result<T, Error>)->Void) {
        dataTask?.cancel()
        
        guard let url = URL(string: "\(networkConfiguration.getBaseUrl())\(path)") else {
            DispatchQueue.main.async {
                completion(.failure(CustomError(message: "wrong url")))
            }
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        for header in networkConfiguration.getHeaders() {
            urlRequest.addValue(header.value, forHTTPHeaderField: header.key)
        }
        
        
        self.dataTask = urlSession.dataTask(with: urlRequest, completionHandler: { [weak self] data, response, error in
            guard let self = self else {
                completion(.failure(CustomError(message: "wrong")))
                return
            }
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
            if let data = data {
                if let content = try? self.jsonDecoder.decode(T.self, from: data) {
                    DispatchQueue.main.async {
                        completion(.success(content))
                    }
                }
            }
        })
        self.dataTask?.resume()
    }
    
    func requestAsync<T:Codable>(path: String, method: Method) async throws ->Result<T, Error> {
        
        guard let url = URL(string: "\(networkConfiguration.getBaseUrl())\(path)") else {
            return .failure(CustomError(message: "wrong url"))
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        for header in networkConfiguration.getHeaders() {
            urlRequest.addValue(header.value, forHTTPHeaderField: header.key)
        }
        
        if let response = try? await urlSession.data(for: urlRequest) {
            let data = response.0
            if let content = try? self.jsonDecoder.decode(T.self, from: data) {
                return .success(content)
            } else {
                return .failure(CustomError(message: "empty"))
            }
        } else {
            return .failure(CustomError(message: "wrong"))
        }
    }
}
