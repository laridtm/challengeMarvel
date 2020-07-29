//
//  CharactersListInteractorTests.swift
//  challangeMarvelTests
//
//  Created by Larissa Diniz on 29/07/20.
//  Copyright © 2020 Larissa Diniz. All rights reserved.
//

import XCTest

class CharactersListInteractorTests: XCTestCase {
    
    var worker: MockCharactersListWorker?
    var interactor: CharactersListInteractorProtocol?
    var presenter: CharactersListPresentable?
    var controller: MockCharactersListViewController?
    
    override func setUp() {
        super.setUp()
        controller = MockCharactersListViewController()
        if let controller = controller {
            presenter = CharactersListPresenter(view: controller)
        }
        if let presenter = presenter {
            worker = MockCharactersListWorker()
            if let worker = worker {
                interactor = CharactersListInteractor(presenter: presenter, worker: worker)
            }
        }
    }
    
    override func tearDown() {
        super.tearDown()
        presenter = nil
        controller = nil
        worker = nil
        interactor = nil
    }
    
    func testIfTheInteractorIsCallingWorker() {
        interactor?.onViewLoad()
        if let worker = worker {
            XCTAssertTrue(worker.getWasCalled)
            XCTAssertTrue(worker.decodeWasCalled)
        }
        
    }
}

class MockCharactersListWorker: CharactersListWorkerProtocol {
    
    var getWasCalled = false
    var decodeWasCalled = false
    
    func get(url: String, completion: @escaping (([Character]) -> Void)) {
        getWasCalled = true
        if let json = "[]".data(using: .utf8) {
            let result = self.decode(data: json)
            if let result = result {
                completion(result)
            }
        }
    }
    
    func decode(data: Data) -> [Character]? {
        decodeWasCalled = true
        return [Character]()
    }
}

class MockCharactersListViewController: CharactersListView {
    var showWasCalled = false
    
    func show(items: [Character]) {
        showWasCalled = true
    }
}


