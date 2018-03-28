//
//  UsersRouter.swift
//  CleanSwiftSample
//
//  Created by Bhatia, Parveen on 03/20/18 Bhatia.
//  Copyright (c) 2018 Bhatia, Parveen. All rights reserved.


import UIKit

protocol UsersRoutingLogic: class
{
    func navigateUserPost(with userDetails: Users.ViewModel.DisplayUser)
}

class UsersRouter: NSObject, UsersRoutingLogic
{
    weak var viewController: UsersViewController?
    
    // MARK: Routing
    
    func navigateUserPost(with userDetails: Users.ViewModel.DisplayUser)
    {
    }
}
