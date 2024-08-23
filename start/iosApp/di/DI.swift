//
//  DI.swift
//  iosApp
//
//  Created by Anna Zharkova on 23.08.2024.
//  Copyright © 2024 orgName. All rights reserved.
//

import Foundation

class DI {
    static let shared = DI()
    
    lazy var networkConfiguration: NetworkConfiguration = {
        return NetworkConfiguration()
    }()
    

    lazy var networkService: NetworkService = {
        return NetworkService(networkConfiguration: networkConfiguration)
    }()
    
    lazy var newsService: NewsService = {
        return NewsService(networkService: networkService)
    }()
    
    lazy var moyaNewsService: NewsMoyaService = {
       return NewsMoyaService()
    }()
    
    lazy var alamofireNetworkService: AlamofireNetworkService = {
        return AlamofireNetworkService(networkConfiguration: networkConfiguration)
    }()
}
