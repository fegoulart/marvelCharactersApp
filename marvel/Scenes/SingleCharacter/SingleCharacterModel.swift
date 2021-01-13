//
//  SingleCharacterModel.swift
//  marvel
//
//  Created by Fernando Luiz Goulart on 12/01/21.
//  Copyright © 2021 Fernando Luiz Goulart. All rights reserved.
//

import UIKit

enum SingleCharacterPage {
    struct DisplayedSingleCharacter {
        var singleCharacterId: Int
        var singleCharacterName: String
        var singleCharacterDescription: String?
        var singleCharacterImage: UIImage
    }
    
    struct DisplayedSingleCharacterComics {
        var singleCharacterComics: [Production]
    }
    
    struct DisplayedSingleCharacterSeries {
        var singleCharacterSeries: [Production]
    }
    
    enum FetchComics {
        struct Request {
            var charactedId: Int
            
        }
        struct Response {
            var comics: Comics?
            var error: SingleCharacterErrors?
        }
        struct ViewModel {
            var comics: DisplayedSingleCharacterComics?
            var error: SingleCharacterErrors?
        }
    }
    
    enum FetchSeries {
        struct Request {
            var characterId: Int
        }
        struct Response {
            var series: Series?
            var error: SingleCharacterErrors?
        }
        struct ViewModel {
            var series: DisplayedSingleCharacterSeries?
            var error: SingleCharacterErrors?
            
        }
        
    }
    
}
