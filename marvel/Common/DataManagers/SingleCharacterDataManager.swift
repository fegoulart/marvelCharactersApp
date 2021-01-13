//
//  SingleCharacterDataManager.swift
//  marvel
//
//  Created by Fernando Luiz Goulart on 12/01/21.
//  Copyright © 2021 Fernando Luiz Goulart. All rights reserved.
//

import PromiseKit

protocol SingleCharacterNetworkInjected {
    
}

struct SingleCharacterNetworkInjector {
    static var networkManager: SingleCharacterDataManager = SingleCharacterNetworkManager()
}

extension SingleCharacterNetworkInjected {
    var singleCharacterDataManager: SingleCharacterDataManager {
        return SingleCharacterNetworkInjector.networkManager
    }
}

protocol SingleCharacterDataManager: AnyObject {
    func getAllComics(limit: Int?, offset: Int?, test: Bool, debugMode: Bool) -> Promise<Comics>
    func getAllSeries(limit: Int?, offset: Int?, test: Bool, debugMode: Bool) -> Promise<Series>
}

extension SingleCharacterDataManager {
    
    func getAllComics(limit: Int? = nil, offset: Int? = nil, test: Bool = false, debugMode: Bool = false) -> Promise<Comics> {
        return getAllComics(limit: limit, offset: offset, test: test, debugMode: debugMode)
    }
    
    func getAllSeries(limit: Int? = nil, offset: Int? = nil, test: Bool = false, debugMode: Bool = false) -> Promise<Series> {
        return getAllSeries(limit: limit, offset: offset, test: test, debugMode: debugMode)
    }
    
}


final class SingleCharacterNetworkManager: SingleCharacterDataManager {

    
//    func getAllCharacters(limit: Int?, offset: Int?, test:Bool,  debugMode: Bool) -> Promise<Characters> {
//        return APIManager.callApi(CharacterAPI.getAllCharacters(limit: limit, offset: offset), dataReturnType: Characters.self, test: test, debugMode: debugMode)
//    }
//
//    func getCharacter(characterId: CharacterId, test: Bool, debugMode: Bool) -> Promise<Character> {
//        return APIManager.callApi(CharacterAPI.getCharacter(characterId: characterId), dataReturnType: Character.self, test: test, debugMode: debugMode)
//    }
    
    
}
