//
//  NewsMoyaService.swift
//  iosApp
//
//  Created by Anna Zharkova on 23.08.2024.
//  Copyright © 2024 orgName. All rights reserved.
//

import Foundation
import Moya


class NewsMoyaService {
    private let jsonDecoder = JSONDecoder()
    private lazy var provider = MoyaProvider<NetworkMoyaService>(
        plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))])
    
    
    func load(completion: @escaping(Result<NewsList, Error>)->Void) {
        self.provider.request(.getNews) { result in
            switch result {
            case .success(let response):
                
                if let content = try? self.jsonDecoder.decode(NewsList.self, from: response.data) {
                    completion(.success(content))
                } else {
                    completion(.failure(CustomError(message: "empty")))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
