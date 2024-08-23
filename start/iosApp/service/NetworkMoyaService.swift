//
//  NetworkMoyaService.swift
//  iosApp
//
//  Created by Anna Zharkova on 23.08.2024.
//  Copyright © 2024 orgName. All rights reserved.
//

import Foundation
import Moya

enum NetworkMoyaService {
    case getNews
}

extension NetworkMoyaService : TargetType {
    var method: Moya.Method {
        .get
    }
    
    var baseURL: URL {
        return URL(string: "https://newsapi.org/v2/")!
    }
    var path: String {
        switch self {
        case .getNews:
            return "everything"
        }
    }
    
    var headers: [String : String]? {
        return ["X-Api-Key":"5b86b7593caa4f009fea285cc74129e2"]
    }
    
    var task: Moya.Task {
        return .requestParameters(parameters: ["q":"science"], encoding: URLEncoding.queryString)
    }
}
