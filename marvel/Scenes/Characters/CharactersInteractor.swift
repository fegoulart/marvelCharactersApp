//
//  CharactersInteractor.swift
//  marvel
//
//  Created by Fernando Luiz Goulart on 31/12/20.
//  Copyright © 2020 Fernando Luiz Goulart. All rights reserved.
//

import Foundation
import UIKit

protocol CharactersBusinessLogic {
    func fetchCharacters(request: CharactersPage.FetchCharacters.Request)
    func fetchNextCharacters(request: CharactersPage.FetchNextCharacters.Request)
    func refreshCharacters(request: CharactersPage.RefreshCharacters.Request)
    func insertFavorite(request: CharactersPage.InsertFavorite.Request)
}

protocol CharactersDataStore {
    var characters: Characters? { get }
    var favorites: [CharacterId]? { get }
}

class CharactersInteractor: CharactersBusinessLogic, CharactersDataStore {
    
    
    var presenter: CharactersPresentationLogic?
    var worker = CharactersWorker()
    var favoritesCoreDataWorker = CharactersCoreDataWorker()
    var characters: Characters?
    var favorites: [CharacterId]?
    let debugMode = false
    
    // MARK: Fetchs characters to display during page loading
    
    func fetchCharacters(request: CharactersPage.FetchCharacters.Request) {
        var response: CharactersPage.FetchCharacters.Response!
        
        // Fetch all local favorites
        
        favoritesCoreDataWorker.favoriteCoreDataManager.getAllFavorites().done {
            favorites in
            
            var newFavorites: [CharacterId] = []
            
            for favorite in favorites {
                if (favorite.isFavorite) {
                    newFavorites.append(Int(favorite.characterId))
                }
            }
            
            
            // Fetch remote characters
            
            self.worker.charactersDataManager.getAllCharacters(limit: nil, offset: nil, test: request.isTest, debugMode: request.isDebugMode).done { characters in
                
                self.characters = characters
                response = CharactersPage.FetchCharacters.Response(characters: self.characters, favorites: newFavorites, error: nil)
            }.catch { error in
                response = CharactersPage.FetchCharacters.Response(characters: nil, error: CharacterErrors.couldNotLoadCharacters(error: error.localizedDescription))
            }.finally {
                self.presenter?.presentCharacters(response: response)
            }
        }.catch { error in
            response = CharactersPage.FetchCharacters.Response(characters: nil, error: CharacterErrors.couldNotLoadFavorites(error: error.localizedDescription))
            
            
        }
    }
    
    func fetchNextCharacters(request: CharactersPage.FetchNextCharacters.Request) {
        var response: CharactersPage.FetchNextCharacters.Response!
        
        worker.charactersDataManager.getAllCharacters(limit: request.limit, offset: request.offset,test: request.isTest).done {
            characters in
            self.characters = characters
            response = CharactersPage.FetchNextCharacters.Response(characters: self.characters, error: nil)
        }.catch { error in
            response = CharactersPage.FetchNextCharacters.Response(characters: self.characters, error: nil)
        }.finally {
            self.presenter?.presentNextCharacters(response:response)
        }
    }
    
    func refreshCharacters(request: CharactersPage.RefreshCharacters.Request) {
        
        var response: CharactersPage.RefreshCharacters.Response!
        
        worker.charactersDataManager.getAllCharacters(limit: nil, offset: nil,test: request.isTest).done {
            characters in
            
            self.characters = characters
            response = CharactersPage.RefreshCharacters.Response(characters: self.characters, error: nil)
        }.catch { error in
            response = CharactersPage.RefreshCharacters.Response(characters: nil, error: CharacterErrors.couldNotLoadCharacters(error: error.localizedDescription))
        }.finally {
            self.presenter?.presentRefreshedCharacters(response: response)
        }
    }
    
    func insertFavorite(request: CharactersPage.InsertFavorite.Request) {
        
        var response: CharactersPage.InsertFavorite.Response!
        favoritesCoreDataWorker.favoriteCoreDataManager.favoriteIt(characterId: request.characterId).done {
            result in
            
            var favorites : [CharacterId] = []
            favorites.append(request.characterId)
            if let currentFavorites = request.currentFavorites {
                for favorite in currentFavorites {
                    favorites.append(favorite)
                }
            }
            response = CharactersPage.InsertFavorite.Response(isSuccess: FavoriteSuccess.success, error: nil, displayedCharacters: request.displayedCharacters, favorites: favorites)
        }.catch { error in
            response = CharactersPage.InsertFavorite.Response(isSuccess: FavoriteSuccess.failure, error: error as? CharacterErrors, displayedCharacters: request.displayedCharacters, favorites: request.currentFavorites)
        }.finally {
            self.presenter?.presentNewFavoriteCharacter(response: response)
        }
        
    }
    
    
}


