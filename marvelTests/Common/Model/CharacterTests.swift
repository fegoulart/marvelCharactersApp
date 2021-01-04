//
//  CharacterTests.swift
//  marvelTests
//
//  Created by Fernando Luiz Goulart on 04/01/21.
//  Copyright © 2021 Fernando Luiz Goulart. All rights reserved.
//

@testable import marvel
import Quick
import Nimble

class CharacterTests: QuickSpec {
    
    override func spec() {
        describe("Character Test") {
            var character: Character!
            var validCharacter: JSONValue!
            
            beforeEach {
                validCharacter = Character.validCharacter
            }
            
            it("should be a valid character") {
                character = try! validCharacter.decode()
                
                expect(character).to(beAKindOf(Character.self))
                expect(character.id) == 1009368
                expect(character.name) == "Iron Man"
                expect(character.description) == "Wounded, captured and forced to build a weapon by his enemies, billionaire industrialist Tony Stark instead created an advanced suit of armor to save his life and escape captivity. Now with a new outlook on life, Tony uses his money and intelligence to make the world a safer, better place as Iron Man."
                expect(character.thumbnail.imagePath) == "http://i.annihil.us/u/prod/marvel/i/mg/9/c0/527bb7b37ff55"
                expect(character.thumbnail.imageExtension) == "jpg"
                expect(character.comics.items.count) == 3
                expect(character.comics.items[0].name) == "A+X (2012) #2"
                expect(character.comics.items[0].resourceURI) == "http://gateway.marvel.com/v1/public/comics/43495"
                expect(character.series.items.count) == 4
                expect(character.series.items[3].name) == "Aero (2019 - Present)"
                expect(character.series.items[3].resourceURI) == "http://gateway.marvel.com/v1/public/series/27392"
                
            }
        }
    }
    
}

/*
 extension Character {
     static let validCharacter : JSONValue = [
         "id": 1009368,
         "name": "Iron Man",
         "description": "Wounded, captured and forced to build a weapon by his enemies, billionaire industrialist Tony Stark instead created an advanced suit of armor to save his life and escape captivity. Now with a new outlook on life, Tony uses his money and intelligence to make the world a safer, better place as Iron Man.",
         "thumbnail":  Thumbnail.validThumbnail,
         "comics": ShortComics.validShortComics,
         "series": ShortSeries.validShortSeries
     ]
 }

 extension Thumbnail {
     static let validThumbnail: JSONValue = [
         "imagePath" : "http://i.annihil.us/u/prod/marvel/i/mg/9/c0/527bb7b37ff55",
         "imageExtension": "jpg"
     ]
 }


 extension ShortComic {
     static let validShortComic1: JSONValue = [
         "resourceURI": "http://gateway.marvel.com/v1/public/comics/43495",
         "name": "A+X (2012) #2"
     ]
     static let validShortComic2: JSONValue = [
         "resourceURI": "http://gateway.marvel.com/v1/public/comics/43506",
         "name":"A+X (2012) #7"
     ]
     static let validShortComic3: JSONValue = [
         "resourceURI": "http://gateway.marvel.com/v1/public/comics/24348",
         "name": "Adam: Legend of the Blue Marvel (Trade Paperback)"
     ]
     
 }

 extension ShortComics {
     static let validShortComics: JSONValue = [
         "items" : [ ShortComic.validShortComic1, ShortComic.validShortComic2, ShortComic.validShortComic3]
     ]
 }

 extension ShortSerie {
     static let validShortSerie1: JSONValue = [
         "resourceURI": "http://gateway.marvel.com/v1/public/series/16450",
         "name": "A+X (2012 - 2014)"
     ]
     static let validShortSerie2: JSONValue = [
         "resourceURI": "http://gateway.marvel.com/v1/public/series/6079",
         "name": "Adam: Legend of the Blue Marvel (2008)"
     ]
     static let validShortSerie3: JSONValue = [
         "resourceURI": "http://gateway.marvel.com/v1/public/series/7524",
         "name": "Adam: Legend of the Blue Marvel (2008)"
     ]
     static let validShortSerie4: JSONValue = [
         "resourceURI": "http://gateway.marvel.com/v1/public/series/27392",
         "name": "Aero (2019 - Present)"
     ]
 }

 extension ShortSeries {
     static let validShortSeries: JSONValue = [
         "items" : [ShortSerie.validShortSerie1, ShortSerie.validShortSerie2, ShortSerie.validShortSerie3, ShortSerie.validShortSerie4]
         
     ]
 }
 */
