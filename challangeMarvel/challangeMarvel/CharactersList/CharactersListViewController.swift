import UIKit

protocol CharactersListView: class {
    func show(items: [Character])
    func append(items: [Character])
}

class CharactersListViewController: UIViewController {
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.itemSize = UICollectionViewFlowLayout.automaticSize

        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.backgroundColor = .clear
        collection.delegate = self
        collection.dataSource = self
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.scrollIndicatorInsets = .zero
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(CharacterViewCell.self, forCellWithReuseIdentifier: "CharacterCell")
        return collection
    }()
    
    var characters: [Character] = []
    var interactor: CharactersListInteractorProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let nib = UINib(nibName: "CharacterViewCell",bundle: nil)
//        self.collectionView.register(nib, forCellWithReuseIdentifier: "CharacterCell")
        
        buildLayout()
        interactor?.onViewLoad()
    }
    
    func buildLayout() {
        buildViewHierarchy()
        setupConstraints()
        configureViews()
//        configureStyles()
    }
    
    func buildViewHierarchy() {
        view.addSubview(collectionView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func configureViews() {
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.topItem?.title = "Marvel"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}

extension CharactersListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCell", for: indexPath) as! CharacterViewCell
        cell.setImage(url: characters[indexPath.row].getCharacterImage())
        if let characterName = characters[indexPath.row].name {
            cell.setName(name: characterName)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let characterSelected: Character? = characters[indexPath.row]
        if let characterDetails = characterSelected {
            let controllerDetails = CharacterDetailsViewController(nibName: "CharacterDetailsViewController", bundle: nil)
            let presenterDetails = CharacterDetailsPresenter(view: controllerDetails)
            let workerDetails = CharacterDetailsWorker()
            let interactorDetails = CharacterDetailsInteractor(presenter: presenterDetails, worker: workerDetails, character: characterDetails)
            controllerDetails.interactor = interactorDetails
            self.navigationController?.present(controllerDetails, animated: true, completion: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
         if (indexPath.row == characters.count - 20) {
            interactor?.loadMoreData()
         }
    }
}

extension CharactersListViewController: CharactersListView {
    func show(items: [Character]) {
        self.characters = items
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func append(items: [Character]) {
        self.characters.append(contentsOf: items)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
