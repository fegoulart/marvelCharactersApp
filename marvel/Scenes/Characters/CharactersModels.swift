//
//  CharactersModels.swift
//  marvel
//
//  Created by Fernando Luiz Goulart on 31/12/20.
//  Copyright © 2020 Fernando Luiz Goulart. All rights reserved.
//

import Foundation
import UIKit

enum CharactersPage {
    
    struct DisplayedCharacter {
        var characterName: String
        var characterImageURL: String
        var isFavorite: Bool
    }
    
    // MARK: Fetch Characters to display during first page load
    enum FetchCharacters {
        struct Request {
            //var offset: Int
            //var limit: Int
            
        }
        struct Response {
            var characters: Characters?
            var error: CharacterErrors?
        }
        struct ViewModel {
            
            var displayedCharacters: [DisplayedCharacter]
            var error: CharacterErrors?
        }
    }
    
    // MARK: Fetch characters to display after page refresh is called
    
    enum RefreshCharacters {
        struct Request {
            
        }
        struct Response {
            var characters: Characters?
            var error: CharacterErrors?
        }
        struct ViewModel {
            
            var displayedCharacters: [DisplayedCharacter]
            var error: CharacterErrors?
        }
    }
    
    
}
