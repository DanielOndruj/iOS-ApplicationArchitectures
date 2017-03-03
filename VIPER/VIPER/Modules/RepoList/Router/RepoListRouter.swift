//
//  RepoListRouter.swift
//  VIPER
//
//  Created by Daniel on 2/5/17.
//  Copyright © 2017 STRV s.r.o. All rights reserved.
//

import Foundation
import UIKit

class RepoListRouter {
    
    weak var viewController: UIViewController?
    
    static func assembleModule() -> UIViewController? {
        
        let view = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: RepoListViewController.controllerIdentifier)) as? RepoListViewController
        let presenter = RepoListPresenter()
        let interactor = RepoListInteractor()
        let router = RepoListRouter()
        
        var navigationController = UINavigationController()
        if let view = view {
            navigationController = UINavigationController(rootViewController: view)
        }
        
        view?.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        router.viewController = view
        
        return navigationController
    }
    
    func presentDetail(model: RepoModel) {

        if let detailsModuleViewController = DetailRouter.assembleModule(model: model) {
            viewController?.navigationController?.pushViewController(detailsModuleViewController, animated: true)
        }
    }
}
