//
//  RepoListViewModel.swift
//  MVVM
//
//  Created by Daniel on 2/4/17.
//  Copyright © 2017 STRV s.r.o. All rights reserved.
//

import Foundation
import UIKit

protocol RepoListViewModelProtocol {
    
    func reloadData()
    func loadingIndicator(show: Bool)
}

class RepoListViewModel: NSObject {
    
    var presenter: RepoListViewModelProtocol?
    var repositories:[RepoModel] = []
    
    func syncData() {
        
        APIService.sharedService.makeAPIRequest(urlString: "https://api.github.com/search/repositories?q=+language:swift&sort=stars&order=desc&page=1&per_page=25", completion: { [weak self] response in
            
            if case Response.success(value: let data) = response {
                self?.repositories = self?.transformDataToDataSource(data: data["items"]) ?? []
                self?.presenter?.reloadData()
            }
            
            self?.presenter?.loadingIndicator(show: false)
        })
    }
    
    func transformDataToDataSource(data:AnyObject?) -> [RepoModel] {
        
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
