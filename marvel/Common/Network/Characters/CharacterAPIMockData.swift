//
//  CharacterAPIMockData.swift
//  marvel
//
//  Created by Fernando Luiz Goulart on 31/12/20.
//  Copyright © 2020 Fernando Luiz Goulart. All rights reserved.
//

import Foundation

extension CharacterAPI {
    var sampleData: Data {
        switch self {
        case .getAllCharacters:
            return stubbedResponse("Characters")
        case .getAllSeries:
            return stubbedResponse("Series")
        case .getAllComics:
            return stubbedResponse("Comics")
        }
    }
}
