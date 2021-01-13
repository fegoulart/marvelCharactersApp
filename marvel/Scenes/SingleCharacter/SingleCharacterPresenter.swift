//
//  SingleCharacterPresenter.swift
//  marvel
//
//  Created by Fernando Luiz Goulart on 12/01/21.
//  Copyright © 2021 Fernando Luiz Goulart. All rights reserved.
//

protocol SingleCharacterPresentationLogic {
    func presentSingleCharacterComics(response: SingleCharacterPage.FetchComics.Response)
    func presentSingleCharacterSeries(response: SingleCharacterPage.FetchSeries.Response)
}

final class SingleCharacterPresenter: SingleCharacterPresentationLogic {
    weak var viewController: SingleCharacterDisplayLogic?
    
    func presentSingleCharacterComics(response: SingleCharacterPage.FetchComics.Response) {
        
        let viewModel = SingleCharacterPage.FetchComics.ViewModel(comics:getDisplayedComics(comics: response.comics), error: response.error)
        viewController?.displayComics(viewModel: viewModel)
     }
     
     func presentSingleCharacterSeries(response: SingleCharacterPage.FetchSeries.Response) {
         let viewModel = SingleCharacterPage.FetchSeries.ViewModel(series:getDisplayedSeries(series: response.series), error: response.error)
         viewController?.displaySeries(viewModel: viewModel)
     }
    
}


extension SingleCharacterPresenter {
    
    private func getDisplayedComics(comics: Comics?) -> SingleCharacterPage.DisplayedSingleCharacterComics {
        guard let comicsArray = comics?.data?.results else { return SingleCharacterPage.DisplayedSingleCharacterComics(singleCharacterComics: [])}
        var productions: [Production] = []
        for comic in comicsArray {
            let newProduction = Production(id: comic.id!, imageURL: "\(comic.thumbnail?.imagePath ?? "").\(comic.thumbnail?.imageExtension ?? "")", name: comic.title ?? "", type: ProductionType.Comic)
            productions.append(newProduction)
        }
        return SingleCharacterPage.DisplayedSingleCharacterComics(singleCharacterComics: productions)
    }
    
    
    private func getDisplayedSeries(series: Series?) -> SingleCharacterPage.DisplayedSingleCharacterSeries {
        guard let seriesArray = series?.data?.results else { return SingleCharacterPage.DisplayedSingleCharacterSeries(singleCharacterSeries: [])}
        var productions: [Production] = []
        for serie in seriesArray {
            let newProduction = Production(id: serie.id!, imageURL: "\(serie.thumbnail?.imagePath ?? "").\(serie.thumbnail?.imageExtension ?? "")", name: serie.title ?? "", type: ProductionType.Serie)
            productions.append(newProduction)
        }
        return SingleCharacterPage.DisplayedSingleCharacterSeries(singleCharacterSeries: productions)
    }
    
}
