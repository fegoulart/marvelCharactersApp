//
//  CharacterDataManagerMock.swift
//  marvelTests
//
//  Created by Fernando Luiz Goulart on 04/01/21.
//  Copyright © 2021 Fernando Luiz Goulart. All rights reserved.
//

import PromiseKit
@testable import marvel

final class CharactersNetworkManagerMock: CharactersDataManager {
    var getAllCharactersCalled = false
    var getCharacterCalled = false
    
    func getAllCharacters(limit: Int?, offset: Int?, test: Bool,  debugMode: Bool) -> Promise<Characters> {
        getAllCharactersCalled = true

        return APIManager.callApi(CharacterAPI.getAllCharacters(limit: limit, offset: offset), dataReturnType: Characters.self, test: true, debugMode: debugMode)
    }
    
    func getCharacter(characterId: Int, _ debugMode: Bool) -> Promise<Character> {
        getCharacterCalled = true
        return APIManager.callApi(CharacterAPI.getCharacter(characterId: characterId), dataReturnType: Character.self, test: true, debugMode: debugMode)
    }
}

enum testError: Error {
    case fakeError
}

final class CharactersNetworkManagerMockError: CharactersDataManager {

    func getAllCharacters(limit: Int?, offset: Int?, test: Bool,  debugMode: Bool) -> Promise<Characters> {
        return Promise(error: testError.fakeError)
    }
    
    func getCharacter(characterId: Int, _ debugMode: Bool) -> Promise<Character> {
        return Promise(error: CharacterErrors.couldNotLoadCharacters(error: "test cannot get data for Character"))
    }
}



