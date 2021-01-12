//
//  FavoritesViewController.swift
//  marvel
//
//  Created by Fernando Luiz Goulart on 12/01/21.
//  Copyright © 2021 Fernando Luiz Goulart. All rights reserved.
//

import UIKit
import Foundation
import SkeletonView

protocol FavoritesDisplayLogic: AnyObject {
    func displayFavoriteCharacters(viewModel: FavoritesPage.FetchPersistedFavorites.ViewModel)
}

class FavoritesViewController: UIViewController, FavoritesDisplayLogic {
    
    var interactor: FavoritesBusinessLogic?
    
    // MARK: Outlets
    
    @IBOutlet weak var favoritesUICollectionView: UICollectionView!
    
    
    // MARK: Variables
    
    var displayedFavoriteCharacters: [FavoritesPage.DisplayedFavoriteCharacter] = []
    
    
    lazy private var flowLayout: TwoColumnsViewFlowLayout = {
        let layout = TwoColumnsViewFlowLayout()
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        return layout
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
        //fetchCoreDataFavorites()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        favoritesUICollectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchCoreDataFavorites()
    }
    
    
}

// MARK: Fetch favorites on screen load

extension FavoritesViewController {
    
    // MARK: Fetch the data to display in the characters collection view
    
    func fetchCoreDataFavorites() {
        let request = FavoritesPage.FetchPersistedFavorites.Request()
        interactor?.selectAllFavorites(request: request)
    }
    
    func displayFavoriteCharacters(viewModel: FavoritesPage.FetchPersistedFavorites.ViewModel) {
        setUpFavoriteCharactersToDisplay(viewModel: viewModel)
    }
    
    private func setUpFavoriteCharactersToDisplay(viewModel: FavoritesPage.FetchPersistedFavorites.ViewModel) {
        
        guard viewModel.error == nil else {
            Alert.showUnableToRetrieveDataAlert(on: self)
            return
        }
        displayedFavoriteCharacters = viewModel.displayedFavoriteCharacters
        favoritesUICollectionView.reloadData()
        
    }
    
}

// MARK: - Collection view delegates

extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayedFavoriteCharacters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = favoritesUICollectionView.dequeueReusableCell(withReuseIdentifier: "FavoritesCell", for: indexPath) as? FavoritesCollectionViewCell, !displayedFavoriteCharacters.isEmpty else {
            return UICollectionViewCell()
        }
        
        
        let favoriteCharacter = self.displayedFavoriteCharacters[indexPath.row]
        cell.update(item: favoriteCharacter)
        return cell
    }
    
    
    
    
}

// MARK: - SkeletonCollectionViewDataSource

extension FavoritesViewController: SkeletonCollectionViewDataSource {
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "FavoritesCell"
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) ->   Int {
        return self.displayedFavoriteCharacters.count
    }
    
    
}


// MARK: Setup

private extension FavoritesViewController {
    
    func setup() {
        let viewController = self
        let interactor = FavoritesInteractor()
        let presenter = FavoritesPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
    
    func setupUI() {
        title = "Favorites"
        view.backgroundColor = .white
        definesPresentationContext = true
        setupCollectionView()
        extendedLayoutIncludesOpaqueBars = true
    }
    
    private func setupCollectionView() {
        favoritesUICollectionView.delegate = self
        favoritesUICollectionView.dataSource = self
        favoritesUICollectionView.isSkeletonable = true
        favoritesUICollectionView.collectionViewLayout = flowLayout
        favoritesUICollectionView.register(UINib(nibName: "FavoritesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FavoritesCell")
    }

}
