//
//  CharacterDetailsPresenterTests.swift
//  challangeMarvelTests
//
//  Created by Larissa Diniz on 29/07/20.
//  Copyright © 2020 Larissa Diniz. All rights reserved.
//

import XCTest

class CharacterDetailsPresenterTests: XCTestCase {
    
    var worker: MockCharacterDetailsWorker?
    var interactor: CharacterDetailsInteractorProtocol?
    var presenter: CharacterDetailsPresentable?
    var controller: MockCharacterDetailsViewController?
    var character: Character?
    var comics: CharacterComicList?
    
    override func setUp() {
        super.setUp()
        comics = CharacterComicList(available: nil, returned: nil, collectionURI: "http://gateway.marvel.com/v1/public/comics/21366", items: nil)
        character = Character(id: nil, name: "Spider-Man", description: nil, modified: nil, thumbnail: nil, comics: comics )
        
        controller = MockCharacterDetailsViewController()
        if let controller = controller {
            presenter = CharacterDetailsPresenter(view: controller)
        }
        if let presenter = presenter {
            worker = MockCharacterDetailsWorker()
            if let worker = worker {
                if let character = character {
                    interactor = CharacterDetailsInteractor(presenter: presenter, worker: worker, character: character)
                }
            }
        }
    }
    
    override func tearDown() {
        super.tearDown()
        presenter = nil
        controller = nil
        worker = nil
        interactor = nil
        character = nil
        comics = nil
    }
    
    func testIfThePresenterIsCallingTheView() {
        interactor?.getCharacterDetails()
        if let controller = controller {
            XCTAssertTrue(controller.showCharacterWasCalled)
            XCTAssertTrue(controller.showComicsWasCalled)
        }
        
    }
}
