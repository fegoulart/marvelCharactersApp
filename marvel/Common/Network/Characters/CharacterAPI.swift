//
//  CharacterAPI.swift
//  marvel
//
//  Created by Fernando Luiz Goulart on 31/12/20.
//  Copyright © 2020 Fernando Luiz Goulart. All rights reserved.
//

import Moya

enum CharacterAPI {
    case getAllCharacters(limit: Int?, offset: Int?)
    case getAllComics(characterId: Int)
    case getAllSeries(characterId: Int)
}

extension CharacterAPI: TargetType {
    
    
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
    
    var path: String {
        switch self {
        case .getAllCharacters:
            return "characters"
        case .getAllComics(let characterId):
            return "characters/\(characterId)/comics"
        case .getAllSeries(let characterId):
            return "characters/\(characterId)/series"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case.getAllCharacters, .getAllComics, .getAllSeries:
            return .get
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .getAllCharacters, .getAllComics, .getAllSeries:
            return URLEncoding.default 
        }
    }
    
    var task: Task {
        switch self {
        case .getAllCharacters(let limit, let offset):
            var params: [String: Any] = [:]
            params["limit"] = limit
            params["offset"] = offset
            params["ts"] = APIConfig.ts
            params["apikey"] = APIConfig.apikey
            params["hash"] = APIConfig.hash
            params["orderBy"]="name"
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .getAllComics, .getAllSeries:
            var params: [String: Any] = [:]
            params["ts"] = APIConfig.ts
            params["apikey"] = APIConfig.apikey
            params["hash"] = APIConfig.hash
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    
    
}
