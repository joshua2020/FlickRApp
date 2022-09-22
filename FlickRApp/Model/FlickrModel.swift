//
//  FlickrModel.swift
//  FlickRApp
//
//  Created by Joshua on 21/09/2022.
//

import Foundation

// MARK: - Welcome
struct FlickrModel: Codable {
   let title: String
    let link: String
    let welcomeDescription: String
    let modified: String
    let generator: String
    let items: [PhotoItem]

    enum CodingKeys: String, CodingKey {
        case title
        case link
        case welcomeDescription = "description"
        case modified, generator, items
    }
}

// MARK: - Item
struct PhotoItem: Codable {
    let title: String
    let link: String
    let media: [String: String]
    let dateTaken: String
    let itemDescription: String
    let published: String
    let author, authorID, tags: String
    let id: String

    enum CodingKeys: String, CodingKey {
        case title
        case link, media
        case dateTaken = "date_taken"
        case itemDescription = "description"
        case published, author
        case authorID = "author_id"
        case tags
        case id
    }
}

// MARK: - Media
struct Media: Codable {
    let m: String
}

extension PhotoItem {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decode(String.self, forKey: .title)
        link = try values.decode(String.self, forKey: .link)
        media = try values.decode(Dictionary<String, String>.self, forKey: .media)
        dateTaken = try values.decode(String.self, forKey: .dateTaken)
        itemDescription = try values.decode(String.self, forKey: .itemDescription)
        published = try values.decode(String.self, forKey: .published)
        author = try values.decode(String.self, forKey: .author)
        authorID = try values.decode(String.self, forKey: .authorID)
        tags = try values.decode(String.self, forKey: .tags)
        id = UUID().uuidString
    }
}


