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
        var characterId: CharacterId
        var characterName: String
        var characterImageURL: String
        var isFavorite: Bool
    }
    
    struct PaginationStatus {
        var offset: Int
        var limit: Int
        var total: Int
        var count: Int
    }
    
    // MARK: Fetch Characters to display during first page load
    enum FetchCharacters {
        struct Request {
            var isTest: Bool = false
            var isDebugMode: Bool = false
        }
        
        struct Response {
            var characters: Characters?
            var favorites: [CharacterId]?
            var error: CharacterErrors?
        }
        
        struct ViewModel {
            var displayedCharacters: [DisplayedCharacter]
            var paginationStatus: PaginationStatus
            var error: CharacterErrors?
        }
    }
    
    // MARK: Fetch more characters and append to existing after end of screen is reached
    
    enum FetchNextCharacters {
        struct Request {
            var offset: Int
            var limit: Int
            var isTest: Bool = false
        }
        
        struct Response {
            var characters: Characters?
            var favorites: [CharacterId]?
            var error: CharacterErrors?
        }
        
        struct ViewModel {
            var displayedCharacters: [DisplayedCharacter]
            var paginationStatus: PaginationStatus
            var error: CharacterErrors?
        }
    }
    
    // MARK: Fetch characters to display after page refresh is called
    
    enum RefreshCharacters {
        struct Request {
            var isTest: Bool = false
        }
        
        struct Response {
            var characters: Characters?
            var favorites: [CharacterId]?
            var error: CharacterErrors?
        }
        
        struct ViewModel {
            var displayedCharacters: [DisplayedCharacter]
            var paginationStatus: PaginationStatus
            var error: CharacterErrors?
        }
    }

    // MARK: Fetch favorites from Core Data to update cells
    
    enum FetchLocalFavorites {
        struct Request {
            
        }
        
        struct Response {
            var characterIds: [CharacterId]?
            var error: CharacterErrors?
        }
        
        struct ViewModel {
            
        }
        
    }
    
    // MARK: Set character as favorite
    
    enum InsertFavorite {
        struct Request {
            var characterId: CharacterId
            var displayedCharacters: [DisplayedCharacter]?
            var currentFavorites: [CharacterId]?
        }
        
        struct Response {
            var isSuccess: FavoriteSuccess?
            var error: CharacterErrors?
            var displayedCharacters: [DisplayedCharacter]?
            var favorites: [CharacterId]?
            
        }
        
        struct ViewModel {
            var displayedCharacters: [DisplayedCharacter]
            var error: CharacterErrors?
        }
        
    }
    
    
}
