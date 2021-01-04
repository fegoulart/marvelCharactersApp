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
}

protocol CharactersDataStore {
    var characters: Characters? { get }
}

class CharactersInteractor: CharactersBusinessLogic, CharactersDataStore {
    
    var presenter: CharactersPresentationLogic?
    var worker = CharactersWorker()
    var characters: Characters?
    let debugMode = false
    
    // MARK: Fetchs characters to display during page loading
    
    func fetchCharacters(request: CharactersPage.FetchCharacters.Request) {
        var response: CharactersPage.FetchCharacters.Response!
        
        worker.charactersDataManager.getAllCharacters(limit: nil, offset: nil, test: request.isTest, debugMode: request.isDebugMode).done { characters in
            
            self.characters = characters
            response = CharactersPage.FetchCharacters.Response(characters: self.characters, error: nil)
        }.catch { error in
            response = CharactersPage.FetchCharacters.Response(characters: nil, error: CharacterErrors.couldNotLoadCharacters(error: error.localizedDescription))
        }.finally {
            self.presenter?.presentCharacters(response: response)
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
    
    
    
}


