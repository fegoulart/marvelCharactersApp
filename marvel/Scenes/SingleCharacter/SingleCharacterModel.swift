//
//  SingleCharacterModel.swift
//  marvel
//
//  Created by Fernando Luiz Goulart on 12/01/21.
//  Copyright © 2021 Fernando Luiz Goulart. All rights reserved.
//

/*
 
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
 */

enum SingleCharacterPage {
    struct DisplayedSingleCharacter {
        var singleCharacterImageURL: String
        var singleCharacterName: String
        var singleCharacterDescription: String
    }
    
    struct DisplayedSingleCharacterComics {
        var singleCharacterComics: [Production]
    }

    struct DisplayedSingleCharacterSeries {
        var singleCharacterSeries: [Production]
    }
    
    enum FetchSingleCharacter {
        struct Request {
            var singleCharacter: Character?
        }
        
        struct Response {
            var singleCharacter: [DisplayedSingleCharacter]?
            var error: FavoriteErrors?
        }
        
        struct ViewModel {
            var singleCharacter: [DisplayedSingleCharacter]?
            var error: FavoriteErrors?
        }
    }
    
    enum FetchComics {
        
    }
    
    enum FetchSeries {
        
        
    }
    
}
