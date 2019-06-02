//
//  RSSFeedResponse.swift
//  News24RSS
//
//  Created by Wafiq Salie on 2019/06/02.
//  Copyright © 2019 EndCrypt3d. All rights reserved.
//

import Foundation

struct RSSFeedResponse: Codable {
    let status: String
    let feed: Feed
    let items: [Item]
}

extension RSSFeedResponse{
    // MARK: - Feed
    struct Feed: Codable {
        let url: String
        let title: String
        let link: String
        let author, feedDescription, image: String
        
        enum CodingKeys: String, CodingKey {
            case url, title, link, author
            case feedDescription = "description"
            case image
        }
    }
    
    // MARK: - Item
    struct Item: Codable {
        let title, pubDate: String
        let link: String
        let guid, author, thumbnail, itemDescription: String
        let content: String
        let enclosure: Enclosure
        let categories: [JSONAny]
        
        enum CodingKeys: String, CodingKey {
            case title, pubDate, link, guid, author, thumbnail
            case itemDescription = "description"
            case content, enclosure, categories
        }
    }
    
    // MARK: - Enclosure
    struct Enclosure: Codable {
        let link: String
        let type: TypeEnum
        let length: Int
    }
    
    enum TypeEnum: String, Codable {
        case imagePNG = "image/png"
    }
}
