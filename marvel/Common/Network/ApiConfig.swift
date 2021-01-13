//
//  ApiConfig.swift
//  marvel
//
//  Created by Fernando Luiz Goulart on 31/12/20.
//  Copyright © 2020 Fernando Luiz Goulart. All rights reserved.
//

struct APIConfig {

    static let baseUrl = "https://gateway.marvel.com:443/"
    static let apiVersion = "v1"
    static let ts = 1609424333.442628
    static let apikey = "2f63d6c20dbbf54179db421f8af36bf4"
    static let hash = "bc28cae76267fa2378b2d26280a8fe9c"
    
    static func getBaseUrl() -> String {
        return "\(baseUrl)\(apiVersion)/public/"
    }
}
