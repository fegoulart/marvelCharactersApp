//
//  DisplayedCharacterMock.swift
//  marvelTests
//
//  Created by Fernando Luiz Goulart on 04/01/21.
//  Copyright © 2021 Fernando Luiz Goulart. All rights reserved.
//

@testable import marvel

extension CharactersPage.DisplayedCharacter {
    static func makeStub(_ characterId: Int = 101010, characterName: String = "Iron Man", _ characterImageURL: String = "http://i.annihil.us/u/prod/marvel/i/mg/9/c0/527bb7b37ff55.jpg",_ isFavorite: Bool = false) -> CharactersPage.DisplayedCharacter {
        
        return CharactersPage.DisplayedCharacter(characterId: characterId, characterName: characterName, characterImageURL: characterImageURL, isFavorite: isFavorite)
        
    }
}
