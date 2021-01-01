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
    func presentRefreshedCharacters(response: CharactersPage.RefreshCharacters.Response)
}


final class CharactersPresenter: CharactersPresentationLogic {

    weak var viewController: CharactersDisplayLogic?
    
    // MARK: Set characters to be displayed after view did load

    func presentCharacters(response: CharactersPage.FetchCharacters.Response) {
        let displayedCharacters = getDisplayedCharacters(response.characters?.data.results)
        let viewModel = CharactersPage.FetchCharacters.ViewModel(displayedCharacters: displayedCharacters)
        viewController?.displayCharacters(viewModel: viewModel)
    }
    
    func presentRefreshedCharacters(response: CharactersPage.RefreshCharacters.Response) {
        let displayedCharacters = getDisplayedCharacters(response.characters?.data.results)
        let viewModel = CharactersPage.RefreshCharacters.ViewModel(displayedCharacters: displayedCharacters)
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
    
   
}
