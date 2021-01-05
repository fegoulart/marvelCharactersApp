//
//  CharactersPresenterTests.swift
//  marvelTests
//
//  Created by Fernando Luiz Goulart on 05/01/21.
//  Copyright © 2021 Fernando Luiz Goulart. All rights reserved.
//

@testable import marvel
import Quick
import Nimble

class CharactersPresenterTests: QuickSpec {
    
    override func spec() {
        describe("CharactersPresenter tests") {
            
            // MARK: Subject under test
            
            var sut: CharactersPresenter!
            var characters: Characters!
            
            beforeSuite {
                CharactersNetworkInjector.networkManager = CharactersNetworkManagerMock()
                setupCharactersPresenter()
                characters = try! Characters.validCharacters.decode()
            }
            
            // MARK: Test setup
            
            func setupCharactersPresenter() {
                sut = CharactersPresenter()
            }
            
            // MARK: Test doubles
            
            class CharactersPresenterSpy: CharactersDisplayLogic {
                
                var displayCharactersCalled = false
                var displayRefreshedCharactersCalled = false
                var displayNextCharactersCalled = false
                
                
                func displayCharacters(viewModel: CharactersPage.FetchCharacters.ViewModel) {
                    displayCharactersCalled = true
                }
                
                func displayNextCharacters(viewModel: CharactersPage.FetchNextCharacters.ViewModel) {
                    displayNextCharactersCalled = true
                }
                
                func displayRefreshedCharacters(viewModel: CharactersPage.RefreshCharacters.ViewModel) {
                    displayRefreshedCharactersCalled = true
                }
                
            }
            
            // MARK: Tests
            
            context("Display characters in view") {
                it("Should ask to display characters on viewDidLoad") {
                    
                    let spy = CharactersPresenterSpy()
                    sut.viewController = spy
                    let response = CharactersPage.FetchCharacters.Response(characters: characters, error: nil)
                    
                    sut.presentCharacters(response: response)
                    expect(spy.displayCharactersCalled).to(beTrue())
                }
                
                
                it("Should ask to display character refresh is called") {
                    
                    let spy = CharactersPresenterSpy()
                    sut.viewController = spy
                    let response = CharactersPage.RefreshCharacters.Response(characters: characters, error: nil)
                    
                    sut.presentRefreshedCharacters(response: response)
                    expect(spy.displayRefreshedCharactersCalled).to(beTrue())
                }
            }
        }
        
        
    }
    
    
}
