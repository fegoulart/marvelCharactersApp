//
//  FavoritesPresenter.swift
//  marvel
//
//  Created by Fernando Luiz Goulart on 12/01/21.
//  Copyright © 2021 Fernando Luiz Goulart. All rights reserved.
//

protocol FavoritesPresentationLogic {
    func presentFavoriteCharacters(response: FavoritesPage.FetchPersistedFavorites.Response)
}

final class FavoritesPresenter: FavoritesPresentationLogic {
 
    weak var viewController: FavoritesDisplayLogic?
    
    // MARK: Set favorite characters to be displayed after being load from CoreData
    
    func presentFavoriteCharacters(response: FavoritesPage.FetchPersistedFavorites.Response) {
        let viewModel = FavoritesPage.FetchPersistedFavorites.ViewModel(displayedFavoriteCharacters: response.favorites ?? [], error: response.error)
        viewController?.displayFavoriteCharacters(viewModel: viewModel)
     }
    
}
