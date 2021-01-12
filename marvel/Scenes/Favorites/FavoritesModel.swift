//
//  FavoritesModel.swift
//  marvel
//
//  Created by Fernando Luiz Goulart on 12/01/21.
//  Copyright © 2021 Fernando Luiz Goulart. All rights reserved.
//

import Foundation
import UIKit

enum FavoritesPage {
    struct DisplayedFavoriteCharacter {
        var favoriteCharacterId: CharacterId
        var favoriteCharacterName: String
        var favoriteCharacterImage: UIImage
    }
    
    enum FetchPersistedFavorites {
        struct Request {
            
        }
        
        struct Response {
            var favorites: [DisplayedFavoriteCharacter]?
            var error: FavoriteErrors?
        }
        
        struct ViewModel {
            var displayedFavoriteCharacters: [DisplayedFavoriteCharacter]
            var error: FavoriteErrors?
        }
        
    }
}

