//
//  CharactersListViewController.swift
//  challangeMarvel
//
//  Created by Larissa Diniz on 28/07/20.
//  Copyright © 2020 Larissa Diniz. All rights reserved.
//

import UIKit

protocol CharactersListView: class {
    func show(items: [Character])
}

class CharactersListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var characters: [Character] = []
    var interactor: CharactersListInteractorProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "CharacterViewCell",bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "CharacterCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.navigationController?.navigationBar.barStyle = .black
//        let tittleImage = UIImage(named: "marvel-logo")
//        self.navigationController?.navigationItem.titleView = UIImageView(image: tittleImage)
        self.navigationController?.navigationBar.topItem?.title = "Marvel"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        interactor?.onViewLoad()
    }
    
    func searchButtonTapped(){
        print("oi")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCell", for: indexPath) as! CharacterViewCell
        
        guard let urlPath = characters[indexPath.row].thumbnail?.path else { return UICollectionViewCell() }
        guard let urlExt = characters[indexPath.row].thumbnail?.ext else { return UICollectionViewCell() }
        let urlImage = "\(urlPath)/portrait_xlarge.\(urlExt)"
        cell.setCharacterImage(url: urlImage)
        if let characterName = characters[indexPath.row].name {
            cell.setCharacterName(name: characterName)
        }
        
        return cell
    }
    
}

extension CharactersListViewController: CharactersListView {
    
    func show(items: [Character]) {
        self.characters = items
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
