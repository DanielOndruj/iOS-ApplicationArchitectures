//
//  DetailInteractor.swift
//  VIPER
//
//  Created by Daniel on 2/5/17.
//  Copyright © 2017 STRV s.r.o. All rights reserved.
//

import Foundation

// MARK: - DetailInteractorInputInterface declaration

protocol DetailInteractorInputInterface: class { }

// MARK: - DetailInteractorInputInterface declaration

protocol DetailInteractorOutputInterface: class { }

// MARK: - DetailInteractor declaration

class DetailInteractor {
    
    // Reference to the Presenter by Interactor interface
    weak var presenter: DetailInteractorOutputInterface?
}

// MARK: - DetailInteractorInputInterface

extension DetailInteractor: DetailInteractorInputInterface {

}
