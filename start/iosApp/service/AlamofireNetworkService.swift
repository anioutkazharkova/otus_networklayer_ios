//
//  AlamofireNetworkService.swift
//  iosApp
//
//  Created by Anna Zharkova on 23.08.2024.
//  Copyright © 2024 orgName. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireNetworkService {
    private let networkConfiguration: NetworkConfiguration
    private let jsonDecoder = JSONDecoder()
    
    init(networkConfiguration: NetworkConfiguration) {
        self.networkConfiguration = networkConfiguration
    }
    
    let sessionManager: Session = {
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 30
        return Session(configuration: configuration)
    }()
    
    func doRequest<T:Codable>(path: String, completion: @escaping(Result<T, Error>)->Void) {
        AF.request("\(networkConfiguration.getBaseUrl())\(path)", method: .get, headers: HTTPHeaders(networkConfiguration.getHeaders()))
            .response { response in
                if let data = response.data {
                    if let content = try? self.jsonDecoder.decode(T.self, from: data) {
                        DispatchQueue.main.async {
                            completion(.success(content))
                        }
                    }
                }
            }
    }
}
