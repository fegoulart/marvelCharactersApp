//
//  CharactersInteractorTests.swift
//  marvelTests
//
//  Created by Fernando Luiz Goulart on 05/01/21.
//  Copyright © 2021 Fernando Luiz Goulart. All rights reserved.
//

@testable import marvel

import Quick
import Nimble
import PromiseKit

class CharactersInteractorTests: QuickSpec {
    
    override func spec() {
        
        // MARK: Subject under test
        
        var sut: CharactersInteractor!
        
        beforeSuite {
            setupCharactersInteractor()
        }
        
        afterSuite {
            CharactersNetworkInjector.networkManager = CharactersNetworkManager()
        }
        
        // MARK: Test setup
        
        func setupCharactersInteractor() {
            sut = CharactersInteractor()
        }
        
        describe("CharactersInteractor tests") {
            // MARK: Test doubles
            
            class CharactersPresentationLogicSpy: CharactersPresentationLogic {
                
                var presentCharactersCalled = false
                var presentNextCharactersCalled = false
                var presentRefreshedCharactersCalled = false
                var characters: Characters?
                var fetchCharacterResponse: CharactersPage.FetchCharacters.Response!
                var fetchNextCharacterResponse: CharactersPage.FetchNextCharacters.Response!
                var fetchRefreshedCharacterResponse: CharactersPage.RefreshCharacters.Response!
                
                func presentCharacters(response: CharactersPage.FetchCharacters.Response) {
                    presentCharactersCalled = true
                    fetchCharacterResponse = response
                    characters = response.characters
                }
                
                func presentNextCharacters(response: CharactersPage.FetchNextCharacters.Response) {
                    presentNextCharactersCalled = true
                    fetchNextCharacterResponse = response
                    characters = response.characters
                }
                
                func presentRefreshedCharacters(response: CharactersPage.RefreshCharacters.Response) {
                    presentRefreshedCharactersCalled = true
                    fetchRefreshedCharacterResponse = response
                    characters = response.characters
                }
            }
            
            // MARK: Tests
            
            context("Set Up call presenter function with good values") {
                beforeEach {
                    CharactersNetworkInjector.networkManager = CharactersNetworkManagerMock()
                }
                
                it("Sould call the presentLaunches function") {
                    let spy = CharactersPresentationLogicSpy()
                    let spyWorker = sut.worker.charactersDataManager as! CharactersNetworkManagerMock
                    sut.presenter = spy
                    let request =  CharactersPage.FetchCharacters.Request(isTest: true, isDebugMode: false)
                    
                    sut.fetchCharacters(request: request)
                    
                    expect(spy.presentCharactersCalled).toEventually(beTrue()) //toEventually is Nimble way to check asynchronous response until timeout is reached
                    expect(spy.characters?.data.results.count).toEventually(equal(20))
                    expect(spyWorker.getAllCharactersCalled).to(beTrue())
                }
                
                it("Sould call the presentNextCharacters function") {
                    let spy = CharactersPresentationLogicSpy()
                    let spyWorker = sut.worker.charactersDataManager as! CharactersNetworkManagerMock
                    sut.presenter = spy
                    let request =  CharactersPage.FetchNextCharacters.Request(offset: 20, limit: 20, isTest: true)
                    
                    sut.fetchNextCharacters(request: request)
                    expect(spy.presentNextCharactersCalled).toEventually(beTrue())
                    expect(spy.characters?.data.results.count).toEventually(equal(20))
                    expect(spy.characters?.data.results[0].name).toEventually(equal("6-D Man"))
                    expect(spyWorker.getAllCharactersCalled).to(beTrue())
                }
                
                it("Sould call the presentRefreshedCharacters function & return 20 characters") {
                    let spy = CharactersPresentationLogicSpy()
                    let spyWorker = sut.worker.charactersDataManager as! CharactersNetworkManagerMock
                    sut.presenter = spy
                    let request =  CharactersPage.RefreshCharacters.Request(isTest: true)
                    
                    sut.refreshCharacters(request: request)
                    expect(spy.presentRefreshedCharactersCalled).toEventually(beTrue())
                    expect(spy.characters?.data.results.count).toEventually(equal(20))
                    expect(spy.characters?.data.results[0].name).toEventually(equal("6-D Man"))
                    expect(spyWorker.getAllCharactersCalled).to(beTrue())
                }
            }
            
            context("Should call function with error case") {
                beforeEach {
                    CharactersNetworkInjector.networkManager = CharactersNetworkManagerMockError()
                }
                
                it("Should return an error") {
                    let spy = CharactersPresentationLogicSpy()
                    _ = sut.worker.charactersDataManager as! CharactersNetworkManagerMockError
                    sut.presenter = spy
                    let request =  CharactersPage.FetchCharacters.Request(isTest: true)
                    
                    sut.fetchCharacters(request: request)
                    
                    expect(spy.fetchCharacterResponse).toEventuallyNot(beNil())
                    expect(spy.fetchCharacterResponse.characters).toEventually(beNil())
                    expect(spy.fetchCharacterResponse.error).toEventuallyNot(beNil())
                }
            }
        }
        
    }
}


