//
//  RepoInfoTableViewCell.swift
//  MVC
//
//  Created by Daniel on 2/4/17.
//  Copyright © 2017 STRV s.r.o. All rights reserved.
//

import UIKit

protocol RepoInfoCellProtocol {

    var repoName:String? { get }
    var repoDescription:String? { get }
    var repoStars:String? { get }
    var repoUpdated:String? { get }
}

class RepoInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var updatedLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    
    class var cellIdentifier: String {
        return String(describing: self)
    }
    
    func configure(model: RepoInfoCellProtocol) {
        
        titleLabel.text = model.repoName
        descriptionLabel.text = model.repoDescription
        starsLabel.text = model.repoStars
        updatedLabel.text = model.repoUpdated
    }
}
