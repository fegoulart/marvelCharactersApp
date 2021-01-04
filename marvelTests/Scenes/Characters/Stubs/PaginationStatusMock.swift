//
//  File.swift
//  marvelTests
//
//  Created by Fernando Luiz Goulart on 04/01/21.
//  Copyright © 2021 Fernando Luiz Goulart. All rights reserved.
//

@testable import marvel

extension CharactersPage.PaginationStatus {
    
    static func makeStub(_ offset: Int = 0, _ limit: Int = 20, _ total: Int = 1943, _ count: Int = 20) -> CharactersPage.PaginationStatus {
        return CharactersPage.PaginationStatus(offset: offset, limit: limit, total: total, count: count)
    }
    
//    static func makeStub(_ offset: Int = 0 , _ limit: Int = 20 , _ total: Int = 1943 , _ count: Int = 20) -> CharactersPage.PaginationStatus {
//
//        return CharactersPage.PaginationStatus(offset: offset, limit: limit, total: total, count: count)
//    }
    
}

/*
 struct PaginationStatus {
     var offset: Int
     var limit: Int
     var total: Int
     var count: Int
 }
 */
