//
//  Character.swift
//  marvel
//
//  Created by Fernando Luiz Goulart on 31/12/20.
//  Copyright © 2020 Fernando Luiz Goulart. All rights reserved.
//

import Foundation

typealias CharacterId = Int

enum FavoriteSuccess: Int {
    case success = 0
    case failure = 1
}

struct Characters: Codable {
    let code: Int
    let status: String
    let data: CharactersData
}

struct CharactersData: Codable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [Character]
}

struct Character: Codable {
    
    // MARK: Character info
    let id: CharacterId
    let name: String
    let description: String
    let thumbnail: Thumbnail
    let comics: ShortComics
    let series: ShortSeries
    
}

struct Thumbnail: Codable {
    let imagePath: String
    let imageExtension: String
    
    enum CodingKeys: String, CodingKey {
           case imagePath = "path"
           case imageExtension = "extension"
       }
}


struct ShortComics: Codable {
    let items: [ShortComic]
}

struct ShortComic: Codable {
    let resourceURI: String
    let name: String
}

struct ShortSeries: Codable {
    let items: [ShortSerie]
}

struct ShortSerie: Codable {
    let resourceURI: String
    let name: String
}

enum ProductionType {
    case Serie, Comic
}

struct Production {
    let imageURL: String
    let name: String
    let type: ProductionType
}
