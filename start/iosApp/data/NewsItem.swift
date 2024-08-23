//
//  NewsItem.swift
//  cleanswiftotus
//
//  Created by Anna Zharkova on 11.10.2022.
//

import Foundation

struct NewsItem : Codable, Identifiable {
    var id = UUID().uuidString
    var url: String?
    var urlToImage: String?
    var author: String?
    var title: String?
    var content: String?
    var publishedAt: String?
    var _description: String?
    
    enum CodingKeys: String, CodingKey {
        case author = "author"
        case title = "title"
        case content = "content"
        case publishedAt = "publishedAt"
        case url = "url"
        case urlToImage = "urlToImage"
        case _description = "description"
    }
}


struct NewsList : Codable {
    var articles: [NewsItem] = [NewsItem]()
    
    enum CodingKeys: String, CodingKey {
        case articles = "articles"
    }
}
