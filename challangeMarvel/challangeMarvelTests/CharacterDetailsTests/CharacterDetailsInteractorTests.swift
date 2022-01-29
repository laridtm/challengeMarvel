//
//  CharacterDetailsInteractorTests.swift
//  challangeMarvelTests
//
//  Created by Larissa Diniz on 29/07/20.
//  Copyright © 2020 Larissa Diniz. All rights reserved.
//

import XCTest

class CharacterDetailsInteractorTests: XCTestCase {
    
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
    
    func testIfTheInteractorIsCallingWorker() {
        interactor?.onViewLoad()
        if let worker = worker {
            XCTAssertTrue(worker.getComicsWasCalled)
            XCTAssertTrue(worker.decodeWasCalled)
        }
        
    }
}

class MockCharacterDetailsWorker: CharacterDetailsWorkerProtocol {
    
    var getCharacterImageWascalled = false
    var getComicsWasCalled = false
    var decodeWasCalled = false
    
    func decode(data: Data) -> [Comic]? {
        decodeWasCalled = true
        return [Comic]()
    }
    
    func getCharacterImage(url: String, completion: @escaping ((UIImage?) -> Void)) {
        getCharacterImageWascalled = true
        completion(nil)
    }
    
    func getComics(url: String, completion: @escaping (([Comic]) -> Void)) {
        getComicsWasCalled = true
        if let json = "[]".data(using: .utf8) {
            let result = self.decode(data: json)
            if let result = result {
                completion(result)
            }
        }
    }
}

class MockCharacterDetailsViewController: CharacterDetailsView {
    
    var showCharacterWasCalled = false
    var showImageWasCalled = false
    var showComicsWasCalled = false
    
    func show(character: Character) {
        showCharacterWasCalled = true
    }
    
    func show(image: UIImage) {
        showImageWasCalled = true
    }
    
    func show(comics: [Comic]) {
        showComicsWasCalled = true
    }
}
