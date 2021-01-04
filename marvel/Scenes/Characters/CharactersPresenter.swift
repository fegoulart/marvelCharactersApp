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
}


final class CharactersPresenter: CharactersPresentationLogic {
 
    weak var viewController: CharactersDisplayLogic?
    
    // MARK: Set characters to be displayed after view did load

    func presentCharacters(response: CharactersPage.FetchCharacters.Response) {
        let displayedCharacters = getDisplayedCharacters(response.characters?.data.results)
        let paginationStatus = getPaginationStatus(response.characters?.data)
        let viewModel = CharactersPage.FetchCharacters.ViewModel(displayedCharacters: displayedCharacters, paginationStatus: paginationStatus)
        viewController?.displayCharacters(viewModel: viewModel)
    }
    
    // MARK: Set characters to be displayed after new characters fetched
    
    func presentNextCharacters(response: CharactersPage.FetchNextCharacters.Response) {
         let newDisplayedCharacters = getDisplayedCharacters(response.characters?.data.results)
        let paginationStatus = getPaginationStatus(response.characters?.data)
        let viewModel = CharactersPage.FetchNextCharacters.ViewModel(displayedCharacters: newDisplayedCharacters, paginationStatus: paginationStatus)
        viewController?.displayNextCharacters(viewModel: viewModel)
     }
    
    // MARK: Set characters to be displayed after a refresh
    
    func presentRefreshedCharacters(response: CharactersPage.RefreshCharacters.Response) {
        let displayedCharacters = getDisplayedCharacters(response.characters?.data.results)
        let paginationStatus = getPaginationStatus(response.characters?.data)
        let viewModel = CharactersPage.RefreshCharacters.ViewModel(displayedCharacters: displayedCharacters, paginationStatus: paginationStatus)
        viewController?.displayRefreshedCharacters(viewModel: viewModel)
    }
    
    
}

extension CharactersPresenter {
    
    private func getDisplayedCharacters(_ charactersToDisplay: [Character]?) -> [CharactersPage.DisplayedCharacter] {
        
        var displayedCharacters: [CharactersPage.DisplayedCharacter] = []
        
        //TODO: Check if it is favorite
        if let characters = charactersToDisplay {
            for character in characters {
                let characterName = character.name
                let characterImageUrl = "\(character.thumbnail.imagePath).\(character.thumbnail.imageExtension)"
                
                let displayedCharacter = CharactersPage.DisplayedCharacter(characterName: characterName, characterImageURL: characterImageUrl, isFavorite: false)
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
