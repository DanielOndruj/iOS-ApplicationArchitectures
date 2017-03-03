//
//  DetailPresenter.swift
//  VIPER
//
//  Created by Daniel on 2/5/17.
//  Copyright © 2017 STRV s.r.o. All rights reserved.
//

import Foundation

// MARK: - DetailPresenterInputInterface declaration

protocol DetailPresenterInputInterface {
    
    func updateView()
}

// MARK: - DetailPresenter declaration

class DetailPresenter {
    
    // Reference to the View
    weak var view: DetailInputInterface?
    
    // Reference to the Interactor's interface.
    var interactor: DetailInteractorInputInterface?
    
    // Reference to the Router
    var router: DetailRouter?
    
    var model: RepoModel?
}

// MARK: - DetailPresenterInputInterface

extension DetailPresenter: DetailPresenterInputInterface {
    
    func updateView() {

        view?.setupController(model: model)
    }
}

// MARK: - DetailInteractorOutputInterface

extension DetailPresenter: DetailInteractorOutputInterface {
    
}
