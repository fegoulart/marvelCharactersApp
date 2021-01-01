//
//  APIManager.swift
//  marvel
//
//  Created by Fernando Luiz Goulart on 31/12/20.
//  Copyright © 2020 Fernando Luiz Goulart. All rights reserved.
//

import PromiseKit
import Moya

protocol GeneralAPI {
    static func callApi<T: TargetType, U: Decodable>(_ target: T, dataReturnType: U.Type, test: Bool, debugMode: Bool) -> Promise<U>
}

struct APIManager: GeneralAPI {
    
    /// Generic function to call API endpoints using moya and decodable protocol
    ///
    /// - Parameters:
    ///   - target: The network moya target endpoint to call
    ///   - dataReturnType: The typpe of data that is expected to parse from endpoint response
    ///   - test: Boolean that help toggle real network call or simple mock data to be returned by moya
    ///   - debugMode: Toggle the verbose mode of moya
    /// - Returns: A promise containing the dataReturnType set in function params
    static func callApi<Target: TargetType, ReturnedObject: Decodable>(_ target: Target, dataReturnType: ReturnedObject.Type, test: Bool = false, debugMode: Bool = false) -> Promise<ReturnedObject> {
        
        let provider = test ? (MoyaProvider<Target>(stubClosure: MoyaProvider.immediatelyStub)) :
            (debugMode ? MoyaProvider<Target>(plugins: [NetworkLoggerPlugin()]) : MoyaProvider<Target>())
        
        return Promise { seal in
            provider.request(target) { result in
                switch result {
                case let .success(response):
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .formatted(Formatter.iso8601)
                    do {
                        let results = try decoder.decode(ReturnedObject.self, from: response.data)
                        seal.fulfill(results)
                    } catch {
                        seal.reject(error)
                    }
                case let .failure(error):
                    seal.reject(error)
                }
            }
        }
    }
}

