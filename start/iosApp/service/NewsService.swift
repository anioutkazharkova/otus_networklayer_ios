//
//  NewsService.swift
//  iosApp
//
//  Created by Anna Zharkova on 23.08.2024.
//  Copyright © 2024 orgName. All rights reserved.
//

import Foundation

class NewsService {
    private weak var networkService: NetworkService?
    private weak var alamofireNetworkService: AlamofireNetworkService? = DI.shared.alamofireNetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func loadNews(completion: @escaping(Result<NewsList, Error>)->Void) {
        self.networkService?.request(path: "everything?q=science", method: .get, completion: completion)
    }
    
    func loadNewsAsync() async -> Result<NewsList,Error> {
        do {
            return try await self.networkService?.requestAsync(path: "everything?q=science", method: .get) ?? .success(NewsList())
        } catch {
            return .failure(error)
        }
    }
    
    func loadFromAlamofire(completion: @escaping(Result<NewsList, Error>)->Void) {
        self.alamofireNetworkService?.doRequest(path: "everything?q=science", completion: completion)
    }
}
