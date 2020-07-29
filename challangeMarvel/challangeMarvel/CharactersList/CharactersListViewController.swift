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
    func append(items: [Character])
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
        self.navigationController?.navigationBar.topItem?.title = "Marvel"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        interactor?.onViewLoad()
    }
    
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
