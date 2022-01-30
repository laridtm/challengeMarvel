import UIKit

protocol CharacterDetailsView {
    func show(character: Character)
    func show(comics: [Comic])
}

class CharacterDetailsViewController: UIViewController {
    private enum Layout {
        static let estimatedCollectionViewItemSize = CGSize(width: 116, height: 194.5)
        static let imageCornerRadius: CGFloat = 8
    }
    
    private lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var characterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = Layout.imageCornerRadius
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var characterName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 1
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private lazy var characterDescription: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .clear
        textView.textColor = .white
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.textAlignment = .center
        textView.font = .systemFont(ofSize: 16)
        return textView
    }()
    
    private lazy var comicsTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 1
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 18)
        label.text = "Comics"
        return label
    }()
    
    private lazy var collectionViewComics: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = Layout.estimatedCollectionViewItemSize
        layout.itemSize = UICollectionViewFlowLayout.automaticSize

        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
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
    
    var interactor: CharacterDetailsInteractorProtocol?
    private var comics: [Comic] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
        interactor?.getCharacterDetails()
    }
    
    func buildLayout() {
        buildViewHierarchy()
        setupConstraints()
    }
    
    func buildViewHierarchy() {
        container.addSubview(characterImage)
        container.addSubview(characterName)
        container.addSubview(characterDescription)
        container.addSubview(comicsTitle)
        container.addSubview(collectionViewComics)
        view.addSubview(container)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            container.topAnchor.constraint(equalTo: view.topAnchor),
            container.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            characterImage.topAnchor.constraint(equalTo: container.topAnchor, constant: 16),
            characterImage.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            
            characterName.topAnchor.constraint(equalTo: characterImage.bottomAnchor, constant: 8),
            characterName.centerXAnchor.constraint(equalTo: characterImage.centerXAnchor),
            
            characterDescription.topAnchor.constraint(equalTo: characterName.bottomAnchor, constant: 8),
            characterDescription.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            characterDescription.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            characterDescription.bottomAnchor.constraint(lessThanOrEqualTo: comicsTitle.topAnchor, constant: -16),
            
            comicsTitle.bottomAnchor.constraint(equalTo: collectionViewComics.topAnchor, constant: -8),
            comicsTitle.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            
            collectionViewComics.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            collectionViewComics.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            collectionViewComics.heightAnchor.constraint(equalToConstant: Layout.estimatedCollectionViewItemSize.height),
            collectionViewComics.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
    }
}

extension CharacterDetailsViewController: CharacterDetailsView {
    func show(character: Character) {
        characterName.text = character.name
        characterDescription.text = character.description
        characterImage.setImage(url: character.getCharacterImage())
    }
    
    func show(comics: [Comic]) {
        self.comics = comics
        DispatchQueue.main.async {
            self.collectionViewComics.reloadData()
        }
    }
}

extension CharacterDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        comics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCell", for: indexPath) as! CharacterViewCell
        cell.configure(url: comics[indexPath.row].getComicImage(), name: comics[indexPath.row].title)
        
        return cell
    }
}
