//
//  NetworkConfiguraion.swift
//  iosApp
//
//  Created by Anna Zharkova on 23.08.2024.
//  Copyright © 2024 orgName. All rights reserved.
//

import Foundation

class NetworkConfiguration {

    private let apiUrl = "https://newsapi.org/v2/"
    private let apiKey = "API_KEY"

    func getHeaders() -> [String: String] {
        return ["X-Api-Key":apiKey]
    }

    func getBaseUrl() -> String {
        return apiUrl
    }

}
