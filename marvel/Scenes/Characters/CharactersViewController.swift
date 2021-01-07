//
//  CharactersViewController.swift
//  marvel
//
//  Created by Fernando Luiz Goulart on 31/12/20.
//  Copyright © 2020 Fernando Luiz Goulart. All rights reserved.
//

import UIKit
import SkeletonView
import PromiseKit

protocol CharactersDisplayLogic: AnyObject {
    func displayCharacters(viewModel: CharactersPage.FetchCharacters.ViewModel)
    func displayNextCharacters(viewModel: CharactersPage.FetchNextCharacters.ViewModel)
    func displayRefreshedCharacters(viewModel: CharactersPage.RefreshCharacters.ViewModel)
    func displayFavoritesUpdatedCharacter(viewModel: CharactersPage.InsertFavorite.ViewModel)
}

protocol CharacterCellDelegate: AnyObject {
    func favoriteButtonTapped(cell: CharactersCollectionViewCell)
}


final class CharactersViewController: UIViewController, CharactersDisplayLogic, CharacterCellDelegate {

    
    

    var interactor: CharactersBusinessLogic?
    //var router: (NSObjectProtocol & CharactersRoutingLogic & CharactersDataPassing)?
    
    // MARK: Outlets
    
    @IBOutlet weak var charactersCollectionView: UICollectionView!
    
    // MARK: Variables
    
    var displayedCharacters: [CharactersPage.DisplayedCharacter] = []
    var favorites: [CharacterId] = []
    var paginationStatus: CharactersPage.PaginationStatus = CharactersPage.PaginationStatus(offset: 0, limit: 20, total: 0, count: 0)
    
    lazy private var flowLayout: TwoColumnsViewFlowLayout = {
        let layout = TwoColumnsViewFlowLayout()
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        return layout
    }()
    
    
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing characters data ...")
        refreshControl.addTarget(self, action: #selector(refreshCharacters), for: .valueChanged)
        return refreshControl
    }()
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        //fetchLocalFavorites()
        fetchCharacters()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if displayedCharacters.isEmpty {
            charactersCollectionView.prepareSkeleton(completion: { _ in
                self.view.showAnimatedGradientSkeleton()
            })
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        charactersCollectionView.collectionViewLayout.invalidateLayout()
    }
    
}

// MARK: Character Cell Delegate

extension CharactersViewController {
    
    func favoriteButtonTapped(cell: CharactersCollectionViewCell) {
        guard let id = cell.characterId else { return }
        
        if cell.isFavorite {
            let request = CharactersPage.DeleteFavorite.Request(characterId: id, displayedCharacters: self.displayedCharacters, currentFavorites: favorites)
            interactor?.deleteFavorite(request: request)
            
        } else {
            let request = CharactersPage.InsertFavorite.Request(characterId: id, displayedCharacters: self.displayedCharacters, currentFavorites: favorites)
            interactor?.insertFavorite(request: request)
        }
        
    }
}

// MARK: Fetch characters on screen load

extension CharactersViewController {
    
    // MARK: Fetch the data to display in the characters collection view
    
    func fetchCharacters() {
        let request = CharactersPage.FetchCharacters.Request()
        interactor?.fetchCharacters(request: request)
    }
    
    func displayCharacters(viewModel: CharactersPage.FetchCharacters.ViewModel) {
        view.hideSkeleton()
        setRefreshControl()
        setUpCharactersDisplay(viewModel: viewModel)
    }
    
    private func setUpCharactersDisplay(viewModel: CharactersPage.FetchCharacters.ViewModel) {
        //TODO: Error treatment
        //        guard viewModel.error == nil else {
        //            Alert.showUnableToRetrieveDataAlert(on: self)
        //            return
        //        }
        displayedCharacters = viewModel.displayedCharacters
        favorites = viewModel.favorites
        paginationStatus = viewModel.paginationStatus
        charactersCollectionView.reloadData()
    }
}

// MARK: Fetch Next Page Characters data

extension CharactersViewController {
    @objc func fetchNextCharacters(offset: Int, limit: Int, favorites: [CharacterId]) {
        let request = CharactersPage.FetchNextCharacters.Request(offset: offset, limit: limit,currentFavorites: favorites)
        interactor?.fetchNextCharacters(request: request)
    }
    
    func displayNextCharacters(viewModel: CharactersPage.FetchNextCharacters.ViewModel) {
        //view.hideSkeleton()
        
        setUpNewCharactersDisplay(viewModel: viewModel)
        
    }
    
    private func setUpNewCharactersDisplay(viewModel: CharactersPage.FetchNextCharacters.ViewModel) {
        //TODO: Error treatment
        //        guard viewModel.error == nil else {
        //            Alert.showUnableToRetrieveDataAlert(on: self)
        //            return
        //        }
        displayedCharacters += viewModel.displayedCharacters
        paginationStatus = viewModel.paginationStatus
        charactersCollectionView.reloadData()
    }
}

// MARK: Refresh Characters data

extension CharactersViewController {
    @objc func refreshCharacters() {
        let request = CharactersPage.RefreshCharacters.Request()
        interactor?.refreshCharacters(request: request)
    }
    
    func displayRefreshedCharacters(viewModel: CharactersPage.RefreshCharacters.ViewModel) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.refresher.endRefreshing()
        }
        //TODO: Error treatment
        //        guard viewModel.error == nil else {
        //            Alert.showUnableToRetrieveDataAlert(on: self)
        //            return
        //        }
        displayedCharacters = viewModel.displayedCharacters
        paginationStatus = viewModel.paginationStatus
        favorites = viewModel.favorites
        charactersCollectionView.reloadData()
    }
    
}

// MARK: Update favorite data

extension CharactersViewController {
    
    func displayFavoritesUpdatedCharacter(viewModel: CharactersPage.InsertFavorite.ViewModel) {
        displayedCharacters = viewModel.displayedCharacters
        favorites = viewModel.favorites
        charactersCollectionView.reloadData()
    }
}



// MARK: - Collection view delegates

extension CharactersViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayedCharacters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = charactersCollectionView.dequeueReusableCell(withReuseIdentifier: "CharactersCell", for: indexPath) as? CharactersCollectionViewCell, !displayedCharacters.isEmpty else {
            return UICollectionViewCell()
        }
        
        
        if isBottomOfScreen(indexPath: indexPath){
            if hasMoreToLoad() {
                self.paginationStatus.offset += self.paginationStatus.limit
                self.fetchNextCharacters(offset: self.paginationStatus.offset, limit: self.paginationStatus.limit,favorites: self.favorites)
            }
        }
        
        let character = self.displayedCharacters[indexPath.row]
        cell.cellDelegate = self
        cell.update(item: character)
        return cell
    }
    
    private func isBottomOfScreen(indexPath: IndexPath) -> Bool {
        return indexPath.row >= displayedCharacters.count - 1
    }
    
    private func hasMoreToLoad() -> Bool {
        return self.displayedCharacters.count < self.paginationStatus.total
    }
    
}

// MARK: - SkeletonCollectionViewDataSource

extension CharactersViewController: SkeletonCollectionViewDataSource {
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "CharactersCell"
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) ->   Int {
        return self.displayedCharacters.count
    }
    
    
}

// MARK: Setup

private extension CharactersViewController {
    
    func setup() {
        let viewController = self
        let interactor = CharactersInteractor()
        let presenter = CharactersPresenter()
        //let router = CharactersRouter()
        viewController.interactor = interactor
        //viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        //router.viewController = viewController
        //router.dataStore = interactor
    }
    
    func setupUI() {
        view.isSkeletonable = true
        let nav = self.navigationController?.navigationBar
        nav?.isTranslucent = false
        title = "Characters"
        view.backgroundColor = .white
        definesPresentationContext = true
        setupCollectionView()
        extendedLayoutIncludesOpaqueBars = true
    }
    
    private func setupCollectionView() {
        charactersCollectionView.delegate = self
        charactersCollectionView.dataSource = self
        charactersCollectionView.isSkeletonable = true
        charactersCollectionView.collectionViewLayout = flowLayout
        charactersCollectionView.register(UINib(nibName: "CharactersCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CharactersCell")
    }
    
    private func setRefreshControl() {
        guard charactersCollectionView.refreshControl == nil else { return }
        charactersCollectionView.refreshControl = refresher
    }
}
