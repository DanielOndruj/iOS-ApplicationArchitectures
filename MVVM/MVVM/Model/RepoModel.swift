//
//  RepoModel.swift
//  MVC
//
//  Created by Daniel on 2/4/17.
//  Copyright © 2017 STRV s.r.o. All rights reserved.
//

import Foundation

class RepoModel {
    
    var name:String?
    var description:String?
    var stargazers:Int?
    var updated:Date?
    lazy var dateFormater:DateFormatter = {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    init(data:[String:AnyObject]) {
        
        self.name = data["name"] as? String
        self.description = data["description"] as? String
        self.stargazers = data["stargazers_count"] as? Int
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        self.updated = formatter.date(from: (data["updated_at"] as? String) ?? "")
    }
}

extension RepoModel: RepoInfoCellProtocol {

    var repoName: String? {
        return name
    }
    
    var repoDescription: String? {
        return description
    }
    
    var repoStars: String? {
        if let stars = stargazers {
            return String(stars)
        }
        
        return nil
    }
    
    var repoUpdated: String? {
        if let updated = updated {
            return dateFormater.string(from: updated)
        }
        
        return nil
    }
}
