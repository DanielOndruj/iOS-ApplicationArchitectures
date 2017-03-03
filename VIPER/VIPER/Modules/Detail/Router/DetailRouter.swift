//
//  DetailRouter.swift
//  VIPER
//
//  Created by Daniel on 2/5/17.
//  Copyright © 2017 STRV s.r.o. All rights reserved.
//

import Foundation
import UIKit

class DetailRouter {
    
    weak var viewController: UIViewController?
    
    static func assembleModule(model: RepoModel) -> UIViewController? {
        let view = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: DetailViewController.controllerIdentifier)) as? DetailViewController
        let presenter = DetailPresenter()
        let interactor = DetailInteractor()
        let router = DetailRouter()

        view?.presenter = presenter
        presenter.view = view
        presenter.model = model
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.viewController = view

        return router.viewController
    }
}
