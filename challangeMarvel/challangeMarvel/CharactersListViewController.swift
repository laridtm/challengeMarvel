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

class CharactersListViewController: UIViewController {

    var interactor: CharactersListInteractorProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.onViewLoad()
    }
}

extension CharactersListViewController: CharactersListView {
    
    func show(items: [Character]) {
        
    }
}
