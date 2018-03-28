//
//  UsersInteractor.swift
//  CleanSwiftSample
//
//  Created by Bhatia, Parveen on 03/20/18 Bhatia.
//  Copyright (c) 2018 Bhatia, Parveen. All rights reserved.


import UIKit

protocol UsersBusinessLogic
{
    func loadUsers(request: Users.Request)
}

protocol UsersDataStore
{
    var users: [UserDetails]? { get }
}

class UsersInteractor: UsersBusinessLogic, UsersDataStore
{
    var presenter: UsersPresentationLogic?
    lazy var worker: UsersWorker = UsersWorker()
    var users: [UserDetails]?
    
    // MARK: Business Logic
    
    func loadUsers(request: Users.Request)
    {
        worker.getUsers(with: request, closure:{ (userList, isSuccess, error) in
            
            DispatchQueue.main.async {
                if isSuccess, let users = userList
                {
                    self.users = users
                    let response = Users.Response(users: users)
                    self.presenter?.presentUserList(with: response)
                }
                else
                {
                    self.presenter?.presentError(error)
                }
            }
            
        })
        
    }
}
