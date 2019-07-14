//
//  User.swift
//  GitHubUsers
//
//  Created by Chmola Lilia on 7/13/19.
//  Copyright © 2019 Lilia. All rights reserved.
//

import Foundation

struct User {
    
    var avatarUrl: String
    var login: String
    var id: Int
    var type: String
    var siteAdmin: Bool
    
    init?(with dict: [String:Any]) {
        
        guard let avatarUrl = dict["avatar_url"] as? String,
            let login = dict["login"] as? String,
            let id = dict["id"] as? Int,
            let type = dict["type"] as? String,
            let siteAdmin = dict["site_admin"] as? Bool else { return nil }
        
        self.avatarUrl = avatarUrl
        self.login = login
        self.id = id
        self.type = type
        self.siteAdmin = siteAdmin
    }
}


