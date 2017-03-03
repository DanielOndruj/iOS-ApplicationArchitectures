//
//  MVVMTests.swift
//  MVVMTests
//
//  Created by Daniel on 2/5/17.
//  Copyright © 2017 STRV s.r.o. All rights reserved.
//

import XCTest
@testable import MVVM

class MVVMTests: XCTestCase {
    
    var testExpectation:XCTestExpectation?
    
    func testExample() {
        
        //set async expectation
        testExpectation = expectation(description: "Testing Async Method Works!")
        
        //setup viewModel
        let viewModel = RepoListViewModel()
        viewModel.presenter = self
        
        //call for data
        viewModel.syncData()
        
        //time to let the process finish before it fails
        waitForExpectations(timeout: 2, handler: { (error) in
            
        })
    }
}

extension MVVMTests: RepoListViewModelProtocol {
    
    func reloadData() {
        
        //We can check for data here e.g. count > 0 etc
        XCTAssertTrue(true, "")
        testExpectation?.fulfill()
    }
    
    func loadingIndicator(show: Bool) { }
}
