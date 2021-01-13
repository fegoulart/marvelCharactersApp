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
    func getAllComics(characterId: Int, limit: Int?, offset: Int?, test: Bool, debugMode: Bool) -> Promise<Comics>
    func getAllSeries(characterId: Int, limit: Int?, offset: Int?, test: Bool, debugMode: Bool) -> Promise<Series>
}

extension SingleCharacterDataManager {
    
    func getAllComics(characterId: Int, limit: Int? = nil, offset: Int? = nil, test: Bool = false, debugMode: Bool = false) -> Promise<Comics> {
        return getAllComics(characterId: characterId, limit: limit, offset: offset, test: test, debugMode: debugMode)
    }
    
    func getAllSeries(characterId: Int, limit: Int? = nil, offset: Int? = nil, test: Bool = false, debugMode: Bool = false) -> Promise<Series> {
        return getAllSeries(characterId: characterId, limit: limit, offset: offset, test: test, debugMode: debugMode)
    }
    
}


final class SingleCharacterNetworkManager: SingleCharacterDataManager {

    
    func getAllComics(characterId: Int, limit: Int? = nil, offset: Int? = nil, test: Bool = false, debugMode: Bool = false) -> Promise<Comics> {
        return APIManager.callApi(CharacterAPI.getAllComics(characterId: characterId), dataReturnType: Comics.self, test: test, debugMode: debugMode)
    }
    
    func getAllSeries(characterId: Int, limit: Int? = nil, offset: Int? = nil, test: Bool = false, debugMode: Bool = false) -> Promise<Series> {
        return APIManager.callApi(CharacterAPI.getAllSeries(characterId: characterId), dataReturnType: Series.self, test: test, debugMode: debugMode)
    }
    
}
