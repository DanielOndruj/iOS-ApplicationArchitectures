//
//  DetailViewController.swift
//  MVC
//
//  Created by Daniel on 2/4/17.
//  Copyright © 2017 STRV s.r.o. All rights reserved.
//

import UIKit

// MARK: - DetailInterface declaration

protocol DetailInputInterface: class {
    
    func setupController(model: RepoModel?)
}

// MARK: - DetailViewController

class DetailViewController: UIViewController {
    
    // Reference to the Presenter's interface.
    var presenter: DetailPresenterInputInterface!
    
    @IBOutlet weak var detailLabel: UILabel!
    
    class var controllerIdentifier: String {
        return String(describing: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.updateView()
    }
}

// MARK: - DetailInterface

extension DetailViewController: DetailInputInterface {

    func setupController(model: RepoModel?) {
        
        navigationItem.title = model?.name
        detailLabel.text = model?.description
    }
}
