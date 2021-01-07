//
//  CharactersPresenter.swift
//  marvel
//
//  Created by Fernando Luiz Goulart on 01/01/21.
//  Copyright © 2021 Fernando Luiz Goulart. All rights reserved.
//

import UIKit

protocol CharactersPresentationLogic {
    func presentCharacters(response: CharactersPage.FetchCharacters.Response)
    func presentNextCharacters(response: CharactersPage.FetchNextCharacters.Response)
    func presentRefreshedCharacters(response: CharactersPage.RefreshCharacters.Response)
    func presentNewFavoriteCharacter(response: CharactersPage.InsertFavorite.Response)
    func presentRemovedFavoriteCharacter(response: CharactersPage.DeleteFavorite.Response)
}


final class CharactersPresenter: CharactersPresentationLogic {
 
    weak var viewController: CharactersDisplayLogic?
    
    // MARK: Set characters to be displayed after view did load

    func presentCharacters(response: CharactersPage.FetchCharacters.Response) {
        let displayedCharacters = getDisplayedCharacters(response.characters?.data.results, favoriteIds: response.favorites)
        let paginationStatus = getPaginationStatus(response.characters?.data)
        let viewModel = CharactersPage.FetchCharacters.ViewModel(displayedCharacters: displayedCharacters, paginationStatus: paginationStatus, favorites: response.favorites ?? [])
        viewController?.displayCharacters(viewModel: viewModel)
    }
    
    // MARK: Set characters to be displayed after new characters fetched
    
    func presentNextCharacters(response: CharactersPage.FetchNextCharacters.Response) {
        let newDisplayedCharacters = getDisplayedCharacters(response.characters?.data.results, favoriteIds: response.favorites)
        let paginationStatus = getPaginationStatus(response.characters?.data)
        let viewModel = CharactersPage.FetchNextCharacters.ViewModel(displayedCharacters: newDisplayedCharacters, paginationStatus: paginationStatus)
        viewController?.displayNextCharacters(viewModel: viewModel)
     }
    
    // MARK: Set characters to be displayed after a refresh
    
    func presentRefreshedCharacters(response: CharactersPage.RefreshCharacters.Response) {
        let displayedCharacters = getDisplayedCharacters(response.characters?.data.results, favoriteIds: response.favorites)
        let paginationStatus = getPaginationStatus(response.characters?.data)
        let viewModel = CharactersPage.RefreshCharacters.ViewModel(displayedCharacters: displayedCharacters, paginationStatus: paginationStatus, favorites: response.favorites ?? [])
        viewController?.displayRefreshedCharacters(viewModel: viewModel)
    }
    
    func presentNewFavoriteCharacter(response: CharactersPage.InsertFavorite.Response) {
        
        if response.isSuccess == FavoriteSuccess.failure { return }
        guard let newFavorites = response.favorites else { return }
        var currentCharacters : [CharactersPage.DisplayedCharacter] = []
        if let responseCharacters = response.displayedCharacters {
            currentCharacters = responseCharacters
        }
        let displayedCharacters = updateDisplayedCharacters(currentDisplayedCharacters: currentCharacters, favoriteIds: newFavorites)
        let viewModel = CharactersPage.InsertFavorite.ViewModel(displayedCharacters: displayedCharacters, favorites: newFavorites)
        viewController?.displayFavoritesUpdatedCharacter(viewModel: viewModel)
     }
    
    func presentRemovedFavoriteCharacter(response: CharactersPage.DeleteFavorite.Response) {
       
       if response.isSuccess == FavoriteSuccess.failure { return }
       guard let newFavorites = response.favorites else { return }
       var currentCharacters : [CharactersPage.DisplayedCharacter] = []
       if let responseCharacters = response.displayedCharacters {
           currentCharacters = responseCharacters
       }
       let displayedCharacters = updateDisplayedCharacters(currentDisplayedCharacters: currentCharacters, favoriteIds: newFavorites)
       let viewModel = CharactersPage.InsertFavorite.ViewModel(displayedCharacters: displayedCharacters, favorites: newFavorites)
       viewController?.displayFavoritesUpdatedCharacter(viewModel: viewModel)
    }
    
    
}

extension CharactersPresenter {
    
    private func getDisplayedCharacters(_ charactersToDisplay: [Character]?, favoriteIds: [CharacterId]?) -> [CharactersPage.DisplayedCharacter] {
        
        var displayedCharacters: [CharactersPage.DisplayedCharacter] = []
        
        if let characters = charactersToDisplay {
            for character in characters {
                let characterId = character.id
                var isFavorite = false
                if let favorites = favoriteIds {
                    isFavorite = favorites.contains(characterId)
                }
                let characterName = character.name
                let characterImageUrl = "\(character.thumbnail.imagePath).\(character.thumbnail.imageExtension)"
                
                let displayedCharacter = CharactersPage.DisplayedCharacter(characterId: characterId, characterName: characterName, characterImageURL: characterImageUrl, isFavorite: isFavorite)
                displayedCharacters.append(displayedCharacter)
            }
        }
         return displayedCharacters
    }
    
    private func updateDisplayedCharacters(currentDisplayedCharacters: [CharactersPage.DisplayedCharacter]?, favoriteIds: [CharacterId]?) -> [CharactersPage.DisplayedCharacter] {
        
        var displayedCharacters: [CharactersPage.DisplayedCharacter] = []
        
        if let characters = currentDisplayedCharacters {
            for character in characters {
                let characterId = character.characterId
                var isFavorite = false
                if let favorites = favoriteIds {
                    isFavorite = favorites.contains(characterId)
                }
                let characterName = character.characterName
                let characterImageUrl = character.characterImageURL
                
                let displayedCharacter = CharactersPage.DisplayedCharacter(characterId: characterId, characterName: characterName, characterImageURL: characterImageUrl, isFavorite: isFavorite)
                displayedCharacters.append(displayedCharacter)
            }
        }
         return displayedCharacters
        
    }
    
    private func getPaginationStatus(_ characterData: CharactersData?) -> CharactersPage.PaginationStatus {
        
        //TODO: Pull this constant to a global scope
        let DEFAULT_LIMIT = 20
        
        var paginationStatus: CharactersPage.PaginationStatus = CharactersPage.PaginationStatus(offset: 0, limit: DEFAULT_LIMIT, total: 0, count: 0)
        
        if let data = characterData {
            paginationStatus.offset = data.offset
            paginationStatus.limit = data.limit
            paginationStatus.total = data.total
            paginationStatus.count = data.count
        }
        
        return paginationStatus
        
    }
    
   
}
