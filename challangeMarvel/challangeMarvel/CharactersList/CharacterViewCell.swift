import UIKit

class CharacterViewCell: UICollectionViewCell {
    private enum Layout {
        static let characterImageHeight: CGFloat = 225
    }
    
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
        label.numberOfLines = 2
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
        contentView.addSubview(characterImage)
        contentView.addSubview(characterName)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            characterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            characterImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            characterImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            characterImage.heightAnchor.constraint(equalToConstant: Layout.characterImageHeight),
            
            characterName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            characterName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            characterName.topAnchor.constraint(equalTo: characterImage.bottomAnchor),
            characterName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        self.layoutIfNeeded()
//        layer.cornerRadius = 8
//    }
    
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
