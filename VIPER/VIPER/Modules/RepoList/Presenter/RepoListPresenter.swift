//
//  RepoListPresenter.swift
//  VIPER
//
//  Created by Daniel on 2/5/17.
//  Copyright © 2017 STRV s.r.o. All rights reserved.
//

import Foundation

// MARK: - RepoListPresenterInputInterface declaration

protocol RepoListPresenterInputInterface: class {
    
    func getDataSource() -> [RepoModel]
    func updateView()
    func didSelectRepo(model: RepoModel)
}

// MARK: - RepoListPresenter

class RepoListPresenter {
    
    // Reference to the View
    weak var view: RepoListInputInterface?
    
    // Reference to the Interactor's interface.
    var interactor: RepoListInteractorInputInterface?
    
    // Reference to the Router
    var router: RepoListRouter?
    
    // DataSource fetched by Interactor
    var dataSource:[RepoModel] = []
}

// MARK: - RepoListPresenterInputInterface

extension RepoListPresenter: RepoListPresenterInputInterface {
    
    func updateView() {
        view?.loadingIndicator(show: true)
        self.interactor?.syncData()
    }
    
    func didSelectRepo(model: RepoModel) {
        
        router?.presentDetail(model: model)
    }
    
    func getDataSource() -> [RepoModel] {
        
        return dataSource
    }
}

// MARK: - RepoListInteractorOutputInterface

extension RepoListPresenter: RepoListInteractorOutputInterface {

    func dataLoaded(success: Bool, data: [RepoModel]?) {
        
        dataSource = data ?? []
        view?.reloadData()
        view?.loadingIndicator(show: false)
        //show error ...
    }
}
