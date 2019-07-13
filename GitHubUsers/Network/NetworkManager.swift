//
//  NetworkManager.swift
//  GitHubUsers
//
//  Created by Chmola Lilia on 7/13/19.
//  Copyright © 2019 Lilia. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    func getDetailsFrom(since: Int, completion: @escaping ([User]) -> Void) {
        Alamofire.request("https://api.github.com/users?since=\(since)&per_page=30").responseJSON { response in
            if let dataDictArray = response.result.value as? [[String:Any]] {
                var users = [User]()
                for dict in dataDictArray {
                    if let user = User.init(with: dict) {
                        users.append(user)
                    }
                }
                completion(users)
            }
        }
    }
}

