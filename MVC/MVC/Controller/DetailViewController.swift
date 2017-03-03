//
//  DetailViewController.swift
//  MVC
//
//  Created by Daniel on 2/4/17.
//  Copyright © 2017 STRV s.r.o. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    public var model:RepoModel?

    @IBOutlet weak var detailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = model?.name
        detailLabel.text = model?.description
    }
}
