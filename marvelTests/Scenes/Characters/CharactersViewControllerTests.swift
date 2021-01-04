//
//  CharactersInteractorTests.swift
//  marvelTests
//
//  Created by Fernando Luiz Goulart on 03/01/21.
//  Copyright © 2021 Fernando Luiz Goulart. All rights reserved.
//

import Quick
import Nimble
@testable import marvel


class CharactersViewControllerTests: QuickSpec {
    
    override func spec() {
        
        describe("LaunchesViewController tests") {
            
            // MARK: Subject under test
            
            var sut: CharactersViewController!
            var window: UIWindow!
            
            // MARK: Test setup
            
            func setupCharactersViewController() {
                let storyboard = UIStoryboard(name: "Main", bundle:nil)
                sut = storyboard.instantiateViewController(withIdentifier: "CharactersViewController") as? CharactersViewController
            }
            
            beforeEach {
                window = UIWindow(frame: UIScreen.main.bounds)
                setupCharactersViewController()
            }
            
            afterEach {
                window = nil
            }
            
            afterSuite {
                CharactersNetworkInjector.networkManager = CharactersNetworkManager()
            }
            
            
            func loadview() {
                window.addSubview(sut.view)
                sut.beginAppearanceTransition(true, animated: false)
                sut.endAppearanceTransition()
            }
            
            // MARK: Test doubles
            
            class CharactersBusinessLogicSpy: CharactersBusinessLogic {
                
                var fetchCharactersCalled = false
                var fetchNextCharactersCalled = false
                var refreshCharactersCalled = false
                
                func fetchCharacters(request: CharactersPage.FetchCharacters.Request) {
                    fetchCharactersCalled = true
                }
                
                func fetchNextCharacters(request: CharactersPage.FetchNextCharacters.Request) {
                    fetchNextCharactersCalled = true
                }
                
                
                func refreshCharacters(request: CharactersPage.RefreshCharacters.Request) {
                    refreshCharactersCalled = true
                }
            }
            
            //MARK: - Test
            
            context("When view is loaded") {
                it("Should be a CharactersViewController") {
                    expect(sut).to(beAKindOf(CharactersViewController.self))
                }
                
                it("Should fetch Characters informations on start") {
                    let CharactersBusinessLogicSpy = CharactersBusinessLogicSpy()
                    sut.interactor = CharactersBusinessLogicSpy
                    
                    loadview()
                    
                    expect(CharactersBusinessLogicSpy.fetchCharactersCalled).to(beTrue())
                }
            }
            
            context("When collection view is loaded") {

                it("Should have one section in Collection View") {
                    loadview()

                    // Given
                    let collectionView = sut.charactersCollectionView

                    // When

                    let numberOfSections = sut.numSections(in: collectionView!)

                    expect(numberOfSections) == 1
                }

                it("Should have two rows in section of collectionView") {
                    // Given
                    loadview()

                    let displayedCharacters = [CharactersPage.DisplayedCharacter.makeStub(),CharactersPage.DisplayedCharacter.makeStub()]

                    let paginationStatus = CharactersPage.PaginationStatus.makeStub(0,  20, 2, 2)

                    let viewModel = CharactersPage.FetchCharacters.ViewModel(displayedCharacters:displayedCharacters, paginationStatus: paginationStatus , error: nil)

                    sut.displayCharacters(viewModel: viewModel)

                    // When
                    let numberOfRows = sut.charactersCollectionView.numberOfItems(inSection: 0)

                    expect(numberOfRows) == displayedCharacters.count
                }

                it("Should be CharactersCollectionViewCell") {
                    loadview()

                    // Given
                    let collectionView = sut.charactersCollectionView

                    let displayedCharacters = [CharactersPage.DisplayedCharacter.makeStub(),CharactersPage.DisplayedCharacter.makeStub()]

                    let paginationStatus = CharactersPage.PaginationStatus.makeStub(0,  20, 2, 2)

                    let viewModel = CharactersPage.FetchCharacters.ViewModel(displayedCharacters:displayedCharacters, paginationStatus: paginationStatus , error: nil)

                    sut.displayCharacters(viewModel: viewModel)

                    // When

                    let cell = sut.collectionView(collectionView!, cellForItemAt: IndexPath(row: 0, section: 0))

                    expect(cell).to(beAKindOf(CharactersCollectionViewCell.self))
                    guard let launchCell = cell as? CharactersCollectionViewCell else {
                        return fail("Should be a CharactersCollectionViewCell")
                    }

                    /*
                     @IBOutlet weak var topMostUIView: UIView!
                     @IBOutlet weak var favoriteButton: UIButton!

                     @IBOutlet weak var characterNameLabel: UILabel!
                     @IBOutlet weak var characterImageView: UIImageView!
                     */

                    expect(launchCell.characterNameLabel.text) == "Iron Man"
                }
            }

//            context("When refresh is called on the view controller") {
//                it("Should fetch space x Characters when type of lanch is changes in segmented control") {
//                    let CharactersBusinessLogicSpy = CharactersBusinessLogicSpy()
//                    sut.interactor = CharactersBusinessLogicSpy
//
//                    loadview()
//
//                    sut.refreshCharacters()
//
//                    expect(CharactersBusinessLogicSpy.refreshCharactersCalled).to(beTrue())
//                }
//            }
            
        }
    }
}
