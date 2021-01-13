//
//  SingleCharacterViewController.swift
//  marvel
//
//  Created by Fernando Luiz Goulart on 12/01/21.
//  Copyright © 2021 Fernando Luiz Goulart. All rights reserved.
//

import UIKit

protocol SingleCharacterDisplayLogic: AnyObject {
    func displayComics(viewModel: SingleCharacterPage.FetchComics.ViewModel)
    func displaySeries(viewModel: SingleCharacterPage.FetchSeries.ViewModel)
}

final class SingleCharacterViewController: UIViewController, SingleCharacterDisplayLogic {
    
    
    var interactor: SingleCharacterBusinessLogic?
    
    // MARK: Outlets
    
    @IBOutlet weak var singleCharacterImageView: UIImageView!
    @IBOutlet weak var singleCharacterDescription: UILabel!
    @IBOutlet weak var comicsCollectionView: UICollectionView!
    @IBOutlet weak var seriesCollectionView: UICollectionView!
    
    // MARK: Variables
    var displayedSingleCharacter: SingleCharacterPage.DisplayedSingleCharacter?
    
    var displayedComics: [Production]?
    var displayedSeries: [Production]?
    
    private let sectionInsets = UIEdgeInsets(top: 2.0,
                                             left: 10.0,
                                             bottom: 2.0,
                                             right: 10.0)
    
    // Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchComics()
        fetchSeries()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        comicsCollectionView.collectionViewLayout.invalidateLayout()
        seriesCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    
}

// MARK: Fetch comics on screen load

extension SingleCharacterViewController {
    
    func fetchComics() {
        guard let characterId = self.displayedSingleCharacter?.singleCharacterId else { return }
        let request = SingleCharacterPage.FetchComics.Request(charactedId: characterId)
        interactor?.fetchComics(request: request)
        
    }
    
    func displayComics(viewModel: SingleCharacterPage.FetchComics.ViewModel) {
        setUpComicsDisplay(viewModel: viewModel)
    }
    
    private func setUpComicsDisplay(viewModel: SingleCharacterPage.FetchComics.ViewModel) {
        guard viewModel.error == nil else {
            Alert.showUnableToRetrieveDataAlert(on: self)
            return
        }
        displayedComics = viewModel.comics?.singleCharacterComics ?? []
        comicsCollectionView.reloadData()
    }
}


// MARK: Fetch series on screen load

extension SingleCharacterViewController {
    
    func fetchSeries() {
        guard let characterId = self.displayedSingleCharacter?.singleCharacterId else { return }
        let request = SingleCharacterPage.FetchSeries.Request(characterId: characterId)
        interactor?.fetchSeries(request: request)
    }
    
    func displaySeries(viewModel: SingleCharacterPage.FetchSeries.ViewModel) {
        setUpSeriesDisplay(viewModel: viewModel)
    }
    
    private func setUpSeriesDisplay(viewModel: SingleCharacterPage.FetchSeries.ViewModel) {
        guard viewModel.error == nil else {
            Alert.showUnableToRetrieveDataAlert(on: self)
            return
        }
        displayedSeries = viewModel.series?.singleCharacterSeries ?? []
        seriesCollectionView.reloadData()
    }
}

// MARK: - Collection view delegates

extension SingleCharacterViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.comicsCollectionView {
            return displayedComics?.count ?? 0
        }
        if collectionView == self.seriesCollectionView {
            return displayedSeries?.count ?? 0
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == comicsCollectionView {
            
            guard displayedComics != nil else { return UICollectionViewCell()}
            
            guard let cell = comicsCollectionView.dequeueReusableCell(withReuseIdentifier: "ProductionCell", for: indexPath) as? SingleCharacterCollectionViewCell, !displayedComics!.isEmpty else {
                return UICollectionViewCell()
            }
            let comic = self.displayedComics![indexPath.row]
            cell.update(item: comic)
            return cell
        } else {
            if collectionView == seriesCollectionView {
                guard displayedSeries != nil else { return UICollectionViewCell()}
                
                guard let cell = seriesCollectionView.dequeueReusableCell(withReuseIdentifier: "ProductionCell", for: indexPath) as? SingleCharacterCollectionViewCell, !displayedSeries!.isEmpty else {
                    return UICollectionViewCell()
                }
                let serie = self.displayedSeries![indexPath.row]
                cell.update(item: serie)
                return cell
            }
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemsPerColumn = CGFloat(1)
        let paddingSpace = sectionInsets.top * (itemsPerColumn + 1)
        let availableHeight = CGFloat(150) - paddingSpace //150 is the fixed collectionview height
        let heightPerItem = availableHeight / itemsPerColumn
        
        return CGSize(width: heightPerItem, height: heightPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
}

private extension SingleCharacterViewController {
    func setup() {
        let viewController = self
        let interactor = SingleCharacterInteractor()
        let presenter = SingleCharacterPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
    
    func setupUI() {
        let nav = self.navigationController?.navigationBar
        nav?.isTranslucent = false
        title = self.displayedSingleCharacter?.singleCharacterName
        view.backgroundColor = .white
        definesPresentationContext = true
        setupCollectionView()
        singleCharacterImageView.image = self.displayedSingleCharacter?.singleCharacterImage
        singleCharacterDescription.text = self.displayedSingleCharacter?.singleCharacterDescription ?? ""
        extendedLayoutIncludesOpaqueBars = true
        
    }
    
    private func setupCollectionView() {
        comicsCollectionView.delegate = self
        comicsCollectionView.dataSource = self
        comicsCollectionView.register(UINib(nibName:  "SingleCharacterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductionCell")
        //comicsCollectionView.frameLayoutGuid
        
        seriesCollectionView.delegate = self
        seriesCollectionView.dataSource = self
        seriesCollectionView.register(UINib(nibName:  "SingleCharacterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductionCell")
        
        
    }
    
}
