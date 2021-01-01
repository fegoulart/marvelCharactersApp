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
    func refreshCharacters(request: CharactersPage.RefreshCharacters.Request)
}

protocol CharactersDataStore {
    var characters: Characters? { get }
}

class CharactersInteractor: CharactersBusinessLogic, CharactersDataStore {

    var presenter: CharactersPresentationLogic?
    var worker = CharactersWorker()
    var characters: Characters?
    let test = false
    let debugMode = false
    
    // MARK: Fetchs characters to display during page loading
    
    func fetchCharacters(request: CharactersPage.FetchCharacters.Request) {
        var response: CharactersPage.FetchCharacters.Response!
        
        worker.charactersDataManager.getAllCharacters(limit: nil, offset: nil).done { characters in
            self.characters = characters
            response = CharactersPage.FetchCharacters.Response(characters: self.characters, error: nil)
        }.catch { error in
            response = CharactersPage.FetchCharacters.Response(characters: nil, error: CharacterErrors.couldNotLoadCharacters(error: error.localizedDescription))
        }.finally {
            self.presenter?.presentCharacters(response: response)
        }
        
    }
    
    func refreshCharacters(request: CharactersPage.RefreshCharacters.Request) {
        //TODO: Call Worker
    }
  
    
    
}
