//
//  DataManagers.swift
//  marvel
//
//  Created by Fernando Luiz Goulart on 31/12/20.
//  Copyright © 2020 Fernando Luiz Goulart. All rights reserved.
//

import PromiseKit

protocol CharactersNetworkInjected {
    
}

struct CharactersNetworkInjector {
    static var networkManager: CharactersDataManager = CharactersNetworkManager()
}

extension CharactersNetworkInjected {
    var charactersDataManager: CharactersDataManager {
        return CharactersNetworkInjector.networkManager
    }
}

protocol CharactersDataManager: AnyObject {
    func getAllCharacters(limit: Int?, offset: Int?, test: Bool,  debugMode: Bool) -> Promise<Characters>
    func getCharacter(characterId: Int, test: Bool, debugMode: Bool) -> Promise<Character>
}

extension CharactersDataManager {
    //TODO: Save 20 as limit and 0 as offset as a config constant
    func getAllCharacters(limit: Int? = 20, offset: Int? = 0, test: Bool = false, debugMode: Bool = false) -> Promise<Characters> {
        return getAllCharacters(limit: limit, offset: offset, test: test, debugMode: debugMode)
    }
    
    func getCharacter(characterId: Int, test: Bool = false, debugMode: Bool = false ) -> Promise<Character> {
        return getCharacter(characterId: characterId, test: test, debugMode: debugMode)
    }
}


final class CharactersNetworkManager: CharactersDataManager {

    
    func getAllCharacters(limit: Int?, offset: Int?, test:Bool,  debugMode: Bool) -> Promise<Characters> {
        return APIManager.callApi(CharacterAPI.getAllCharacters(limit: nil, offset: nil), dataReturnType: Characters.self, test: test, debugMode: debugMode)
    }
    
    func getCharacter(characterId: Int, test: Bool, debugMode: Bool) -> Promise<Character> {
        return APIManager.callApi(CharacterAPI.getCharacter(characterId: characterId), dataReturnType: Character.self, test: test, debugMode: debugMode)
    }
    
    
}
