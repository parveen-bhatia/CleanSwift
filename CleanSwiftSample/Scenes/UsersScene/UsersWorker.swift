//
//  UsersWorker.swift
//  CleanSwiftSample
//
//  Created by Bhatia, Parveen on 03/20/18 Bhatia.
//  Copyright (c) 2018 Bhatia, Parveen. All rights reserved.


import UIKit

class UsersWorker
{
    func getUsers(with request: Users.Request, closure: @escaping ([UserDetails]?, Bool, Error?) -> Void)
    {
        var httpRequest = URLRequest(url: URL(string: baseURL + "/users")!)
        httpRequest.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: httpRequest) { data, response, error in
            
            guard let data = data, error == nil else
            {
                closure(nil, false, error)
                return
            }
            
            let usersList = try? JSONDecoder().decode(Array<UserDetails>.self, from: data)
            closure(usersList, true, error)
        }
        
        task.resume()
    }

}
