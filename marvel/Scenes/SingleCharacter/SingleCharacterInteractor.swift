//
//  SingleCharacterInteractor.swift
//  marvel
//
//  Created by Fernando Luiz Goulart on 12/01/21.
//  Copyright © 2021 Fernando Luiz Goulart. All rights reserved.
//


protocol SingleCharacterBusinessLogic {
    func fetchComics(request: SingleCharacterPage.FetchComics.Request)
    func fetchSeries(request: SingleCharacterPage.FetchSeries.Request)
}

protocol SingleCharacterDataStore {
    var singleCharacter: Character? { get }
    var comics: Comics? { get }
    var series: Series? { get }
}

class SingleCharacterInteractor: SingleCharacterBusinessLogic, SingleCharacterDataStore {
    var presenter: SingleCharacterPresentationLogic?
    var worker = SingleCharacterWorker()
    var singleCharacter: Character?
    var comics: Comics?
    var series: Series?
    
    // MARK: Fetchs comics to display in comics collectionview
    
    func fetchComics(request: SingleCharacterPage.FetchComics.Request) {
        var response: SingleCharacterPage.FetchComics.Response!
        self.worker.singleCharacterDataManager.getAllComics().done {
            comics in
            
            self.comics = comics
            
            response = SingleCharacterPage.FetchComics.Response(comics: comics, error: nil)
        }.catch { error in
            response = SingleCharacterPage.FetchComics.Response(comics: nil, error: SingleCharacterErrors.couldNotLoadComics(error: error.localizedDescription))
        }.finally {
            self.presenter?.presentSingleCharacterComics(response:  response)
        }
    }
    
    // MARK: Fetchs series to display in comics collectionview
    func fetchSeries(request: SingleCharacterPage.FetchSeries.Request) {
         var response: SingleCharacterPage.FetchSeries.Response!
        
        self.worker.singleCharacterDataManager.getAllSeries().done {
            series in
            self.series = series
            response = SingleCharacterPage.FetchSeries.Response(series: series, error: nil)
            
        }.catch {
            error in
            response = SingleCharacterPage.FetchSeries.Response(series:nil, error: SingleCharacterErrors.couldNotLoadSeries(error: error.localizedDescription))
        }.finally {
            self.presenter?.presentSingleCharacterSeries(response: response)
        }
    }
    

    
    
}
