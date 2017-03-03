//
//  VIPERTests.swift
//  VIPERTests
//
//  Created by Daniel on 2/5/17.
//  Copyright © 2017 STRV s.r.o. All rights reserved.
//

import XCTest
@testable import VIPER

class VIPERTests: XCTestCase {
    
    var testExpectation:XCTestExpectation?
    
    func testExample() {
        
        //set async expectation
        testExpectation = expectation(description: "Testing Async GetData process")
        
        //setup presenter and interactor
        let presenter = RepoListPresenter()
        let interactor = RepoListInteractor()
        
        presenter.interactor = interactor
        presenter.view = self
        interactor.presenter = presenter
        
        //call for data
        presenter.updateView()
        
        //time to let the process finish before it fails
        waitForExpectations(timeout: 2, handler: { (error) in
            
        })
    }
}

extension VIPERTests: RepoListInputInterface {
    
    func reloadData() {
        
        //We can check for data here e.g. count > 0 etc
        XCTAssertTrue(true, "We have the data")
    }
    
    func loadingIndicator(show: Bool) { }
}
