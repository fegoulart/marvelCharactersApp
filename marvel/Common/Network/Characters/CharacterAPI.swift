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
    case getCharacter(characterId: Int)
}

extension CharacterAPI: TargetType {
    

    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
    
    var path: String {
        switch self {
        case .getAllCharacters:
            return "characters"
        case .getCharacter(let characterId):
            return "characters/\(characterId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case.getAllCharacters, .getCharacter:
            return .get
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .getAllCharacters, .getCharacter:
            return URLEncoding.default 
        }
    }
    
    var task: Task {
        switch self {
        case .getAllCharacters(let limit, let offset):
            var params: [String: Any] = [:]
            params["limit"] = limit
            params["offset"] = offset
            params["ts"] = 1609424333.442628
            params["apikey"] = "2f63d6c20dbbf54179db421f8af36bf4"
            params["hash"] = "bc28cae76267fa2378b2d26280a8fe9c"
            params["orderBy"]="name"
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .getCharacter:
            return .requestPlain
        }
    }
    
    
}
