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
    //static let limitDisplay = 20
    
    static func getBaseUrl() -> String {
        return "\(baseUrl)\(apiVersion)/public/"
    }
}
