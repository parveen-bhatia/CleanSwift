//
//  UsersPresenter.swift
//  CleanSwiftSample
//
//  Created by Bhatia, Parveen on 03/20/18 Bhatia.
//  Copyright (c) 2018 Bhatia, Parveen. All rights reserved.


import UIKit

protocol UsersPresentationLogic
{
    func presentUserList(with response: Users.Response)
    func presentError(_ error: Error?)
}

class UsersPresenter: UsersPresentationLogic
{
    weak var viewController: UsersDisplayLogic?
    
    // MARK: Presentation Logic
    
    func presentUserList(with response: Users.Response)
    {
        var displayedUsers: [Users.ViewModel.DisplayUser] = []
        for user in response.users {
            let fullName = user.fullName?.capitalized ?? "NA"
            let addressLine1 = (user.userAddress?.suite ?? "NA") + ", " + (user.userAddress?.street ?? "NA")
            let addressLine2 = (user.userAddress?.city ?? "NA") + ", " + (user.userAddress?.zipcode ?? "NA")
            let displayedUser = Users.ViewModel.DisplayUser(fullName: fullName, addressLine1: addressLine1, addressLine2: addressLine2)
            displayedUsers.append(displayedUser)
        }
        let viewModel = Users.ViewModel(displayedUsers: displayedUsers)
        viewController?.displayUserList(viewModel: viewModel)
    }
    
    func presentError(_ error: Error?)
    {
        NSLog("Load User Failed with Error: %@", error?.localizedDescription ?? "Unknown")
        viewController?.displayError(with: "Not able to load users")
    }

}
