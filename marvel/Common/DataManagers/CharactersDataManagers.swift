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
    func getAllCharacters(limit: Int? = 20, offset: Int? = 0, test: Bool = false, debugMode: Bool = false) -> Promise<Characters> {
        return getAllCharacters(limit: limit, offset: offset, test: test, debugMode: debugMode)
    }
    
    func getCharacter(characterId: CharacterId, test: Bool = false, debugMode: Bool = false ) -> Promise<Character> {
        return getCharacter(characterId: characterId, test: test, debugMode: debugMode)
    }
}


final class CharactersNetworkManager: CharactersDataManager {

    
    func getAllCharacters(limit: Int?, offset: Int?, test:Bool,  debugMode: Bool) -> Promise<Characters> {
        return APIManager.callApi(CharacterAPI.getAllCharacters(limit: limit, offset: offset), dataReturnType: Characters.self, test: test, debugMode: debugMode)
    }
    
    func getCharacter(characterId: CharacterId, test: Bool, debugMode: Bool) -> Promise<Character> {
        return APIManager.callApi(CharacterAPI.getCharacter(characterId: characterId), dataReturnType: Character.self, test: test, debugMode: debugMode)
    }
    
    
}

    // MARK: Core Data Data Manager

protocol FavoritesCoreDataInjected {
    
}

struct FavoritesCoreDataInjector {
    static var coreDataManager: FavoritesDataManager = FavoritesCoreDataManager()
}

extension FavoritesCoreDataInjected {
    var favoriteCoreDataManager: FavoritesDataManager {
        return FavoritesCoreDataInjector.coreDataManager
    }
}

protocol FavoritesDataManager: AnyObject {

    func getAllFavorites() -> Promise<[marvel.Favorite]>
    func favoriteIt(characterId: CharacterId, characterName: String, characterImage: UIImage) -> Promise<FavoriteSuccess>
    func unfavoriteIt(characterId: CharacterId) -> Promise<FavoriteSuccess>
    
}

final class FavoritesCoreDataManager: FavoritesDataManager {
    
    func getAllFavorites() -> Promise<[marvel.Favorite]> {
        return CoreDataAPIManager.callCoreData(operationType: .fetchAll, entityName: "Favorite", dataReturnType: [marvel.Favorite].self, keyValues: [:], sortDescriptors: [NSSortDescriptor(key: "characterName", ascending: true)])
    }
    
    func favoriteIt(characterId: CharacterId, characterName: String, characterImage: UIImage) -> Promise<FavoriteSuccess> {
        
        let insertDictionary = [
            "characterId": characterId,
        "isFavorite": true,
        "characterImage": characterImage.jpegData(withCompressionQuality: 1.0)!,
        "characterName" : characterName
            ] as [String : Any]
        return CoreDataAPIManager.callCoreData(operationType: .insert, entityName: "Favorite", dataReturnType: FavoriteSuccess.self, keyValues: insertDictionary)
    }
    
    func unfavoriteIt(characterId: CharacterId) -> Promise<FavoriteSuccess> {
        return CoreDataAPIManager.callCoreData(operationType: .delete, entityName: "Favorite", dataReturnType: FavoriteSuccess.self, keyValues: ["characterId":characterId])
    }
    
}

