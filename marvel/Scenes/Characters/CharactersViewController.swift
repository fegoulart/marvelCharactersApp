//
//  CharactersViewController.swift
//  marvel
//
//  Created by Fernando Luiz Goulart on 31/12/20.
//  Copyright © 2020 Fernando Luiz Goulart. All rights reserved.
//

import UIKit
import SkeletonView

protocol CharactersDisplayLogic: class {
    func displayCharacters(viewModel: CharactersPage.FetchCharacters.ViewModel)
    func displayRefreshedCharacters(viewModel: CharactersPage.RefreshCharacters.ViewModel)
}


final class CharactersViewController: UIViewController, CharactersDisplayLogic {
    
    var interactor: CharactersBusinessLogic?
    //var router: (NSObjectProtocol & CharactersRoutingLogic & CharactersDataPassing)?
    
    // MARK: Outlets
    
    @IBOutlet weak var charactersCollectionView: UICollectionView!
    
    // MARK: Variables
    
    var displayedCharacters: [CharactersPage.DisplayedCharacter] = []
    
    lazy private var flowLayout: TwoColumnsViewFlowLayout = {
        let layout = TwoColumnsViewFlowLayout()
        //layout.minimumInteritemSpacing = Style.Size.margin
        //layout.minimumLineSpacing = Style.Size.margin
        return layout
    }()
    
//    lazy private var flowLayout: TopAlignedCollectionViewFlowLayout = {
//        let layout = TopAlignedCollectionViewFlowLayout()
//        //layout.minimumInteritemSpacing = Style.Size.margin
//        //layout.minimumLineSpacing = Style.Size.margin
//        return layout
//    }()
    
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing characters data ...")
        refreshControl.addTarget(self, action: #selector(refreshCharacters), for: .valueChanged)
        return refreshControl
    }()
    
    //private lazy var sizingCell: CharactersCollectionViewCell? = .fromNib()
    
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
        let character = self.displayedCharacters[indexPath.row]
        cell.update(item: character)
        return cell
    }
    
    
}

// MARK: - SkeletonCollectionViewDataSource

extension CharactersViewController: SkeletonCollectionViewDataSource {
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "CharactersCell"
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) ->   Int {
        return 20
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
        //nav?.barTintColor = Style.Color.MainGray
        nav?.isTranslucent = false
        nav?.tintColor = .white
        nav?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        title = "Characters"
        //self.navigationItem.searchController = searchController
        self.navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        definesPresentationContext = true
        //setupSegmentedControl()
        setupCollectionView()
        extendedLayoutIncludesOpaqueBars = true
    }
    
    private func setupCollectionView() {
        charactersCollectionView.delegate = self
        charactersCollectionView.dataSource = self
        charactersCollectionView.isSkeletonable = true
        charactersCollectionView.collectionViewLayout = flowLayout
        //charactersCollectionView.contentInset = UIEdgeInsets(top: Style.Size.topMargin, left: Style.Size.margin, bottom: 44, right: Style.Size.margin)
        //charactersCollectionView.scrollIndicatorInsets = UIEdgeInsets(top: Style.Size.topMargin, left: 0, bottom: 0, right: 0)
        charactersCollectionView.backgroundColor = .clear
        charactersCollectionView.register(UINib(nibName: "CharactersCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CharactersCell")
    }
    
    private func setRefreshControl() {
        guard charactersCollectionView.refreshControl == nil else { return }
        charactersCollectionView.refreshControl = refresher
    }
}
