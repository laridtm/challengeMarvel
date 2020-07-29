//
//  CharacterDetailsViewController.swift
//  challangeMarvel
//
//  Created by Larissa Diniz on 29/07/20.
//  Copyright © 2020 Larissa Diniz. All rights reserved.
//

import UIKit

protocol CharacterDetailsView: class {
    func show(character: Character)
    func show(image: UIImage)
    func show(comics: [Comic])
}

class CharacterDetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var characterDescription: UITextView!
    @IBOutlet weak var collectionViewComics: UICollectionView!
    
    
    var interactor: CharacterDetailsInteractorProtocol?
    var comics: [Comic] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "CharacterViewCell",bundle: nil)
        self.collectionViewComics.register(nib, forCellWithReuseIdentifier: "CharacterCell")
        collectionViewComics.delegate = self
        collectionViewComics.dataSource = self
        
        self.characterImage.layer.cornerRadius = 8
        
        interactor?.onViewLoad()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        comics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCell", for: indexPath) as! CharacterViewCell
        cell.setImage(url: comics[indexPath.row].getComicImage())
        if let comicTitle = comics[indexPath.row].title {
            cell.setName(name: comicTitle)
        }
        return cell
    }
}

extension CharacterDetailsViewController: CharacterDetailsView {
    
    func show(character: Character) {
        characterName.text = character.name
        characterDescription.text = character.description
        interactor?.getCharacterImage(url: character.getCharacterImage())
    }
    
    func show(image: UIImage) {
        DispatchQueue.main.async {
            self.characterImage.image = image
        }
    }
    
    func show(comics: [Comic]) {
        self.comics = comics
        DispatchQueue.main.async {
            self.collectionViewComics.reloadData()
        }
    }
}
