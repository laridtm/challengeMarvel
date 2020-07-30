//
//  CharactersListPresenterTests.swift
//  challangeMarvelTests
//
//  Created by Larissa Diniz on 29/07/20.
//  Copyright © 2020 Larissa Diniz. All rights reserved.
//

import XCTest

class CharactersListPresenterTests: XCTestCase {
    
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
    
    func testIfThePresenterIsCallingTheView() {
        interactor?.onViewLoad()
        if let controller = controller {
            XCTAssertTrue(controller.showWasCalled)
        }
    }
    
    func testIfThePresenterIsCallingTheViewToShowMore() {
        interactor?.loadMoreData()
        if let controller = controller {
            XCTAssertTrue(controller.appendWasCalled)
        }
    }
}
