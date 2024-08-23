//
//  NewsListModel.swift
//  iosApp
//
//  Created by Anna Zharkova on 03.10.2021.
//  Copyright © 2021 orgName. All rights reserved.
//

import Foundation
import SwiftUI

class NewsListModel : ObservableObject {
    @Published var items: [NewsItem] = [NewsItem]()
    private weak var newsService: NewsService? = DI.shared.newsService
    private weak var newsMoyaService: NewsMoyaService? = DI.shared.moyaNewsService
    
    
    func loadNews() {
        self.newsService?.loadNews(completion: { result in
            switch result {
            case .success(let articles):
                self.items = articles.articles
            default:
                break
            }
        })
    }
    
    func loadNewsMoya() {
        self.newsMoyaService?.load(completion: { result in
            switch result {
            case .success(let articles):
                self.items = articles.articles
            default:
                break
            }
        })
    }
    
    @MainActor
    func loadNewsAsync() {
        Task {
            let response = await self.newsService?.loadNewsAsync()
            switch response {
            case .success(let data):
                self.items = data.articles
            default:
                break
            }
        }
    }
    
    func loadFromAlamofire() {
        self.newsService?.loadFromAlamofire(completion: { result in
            switch result {
            case .success(let articles):
                self.items = articles.articles
            default:
                break
            }
        })
    }
    
}
