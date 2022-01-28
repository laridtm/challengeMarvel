import UIKit

class CharacterViewCell: UICollectionViewCell {
    private enum Layout {
        static let characterImageHeight: CGFloat = 174
        static let characterImageWidth: CGFloat = 116
        static let cornerRadius: CGFloat = 8
    }
    
    private lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = Layout.cornerRadius
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var characterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var characterName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 1
        label.backgroundColor = .red
        return label
    }()
    
    let httpClient = HTTPClient()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func buildLayout() {
        buildViewHierarchy()
        setupConstraints()
    }
    
    func buildViewHierarchy() {
        container.addSubview(characterImage)
        container.addSubview(characterName)
        contentView.addSubview(container)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            characterImage.topAnchor.constraint(equalTo: container.topAnchor),
            characterImage.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            characterImage.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            characterImage.heightAnchor.constraint(equalToConstant: Layout.characterImageHeight),
            characterImage.widthAnchor.constraint(equalToConstant: Layout.characterImageWidth),
//
            characterName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            characterName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            characterName.topAnchor.constraint(equalTo: characterImage.bottomAnchor),
            characterName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setImage(url: String) {
        if let apiUrl = URL(string: url) {
            httpClient.get(url: apiUrl) { result -> Void in
                switch result {
                case .failure:
                    break
                case .success(let data):
                    DispatchQueue.main.async {
                        let loadedImage = UIImage(data: data)
                        self.characterImage.image = loadedImage
                    }
                    break
                }
            }
        }
    }
    
    func setName(name: String) {
        characterName.text = name
    }
}
