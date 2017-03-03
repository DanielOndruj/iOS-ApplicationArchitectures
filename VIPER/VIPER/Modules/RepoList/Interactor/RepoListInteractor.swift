//
//  RepoListInteractor.swift
//  VIPER
//
//  Created by Daniel on 2/5/17.
//  Copyright © 2017 STRV s.r.o. All rights reserved.
//

import Foundation

// MARK: - RepoListInteractorInputInterface declaration

protocol RepoListInteractorInputInterface: class {
    
    func syncData()
}

// MARK: - RepoListInteractorOutputInterface declaration

protocol RepoListInteractorOutputInterface: class {
    
    func dataLoaded(success: Bool, data: [RepoModel]?)
}

// MARK: - RepoListInteractor

class RepoListInteractor {
    
    // Reference to the Presenter's output interface.
    weak var presenter: RepoListInteractorOutputInterface?
}

// MARK: - RepoListInteractorInputInterface

extension RepoListInteractor: RepoListInteractorInputInterface {
    
    func syncData() {
        
        APIService.sharedService.makeAPIRequest(urlString: "https://api.github.com/search/repositories?q=+language:swift&sort=stars&order=desc&page=1&per_page=25", completion: { [weak self] response in
            
            if case Response.success(value: let data) = response {
                let dataSource = self?.transformDataToDataSource(data: data["items"]) ?? []
                self?.presenter?.dataLoaded(success: true, data: dataSource)
            } else {
                self?.presenter?.dataLoaded(success: false, data: nil)
            }
        })
    }
    
    fileprivate func transformDataToDataSource(data:AnyObject?) -> [RepoModel] {
        
        if let data = data as? [[String:AnyObject]] {
            return data.map { (dataItem) -> RepoModel in
                let newRepo = RepoModel(data: dataItem)
                return newRepo
            }
        } else {
            return []
        }
    }
}
