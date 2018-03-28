//
//  UsersModels.swift
//  CleanSwiftSample
//
//  Created by Bhatia, Parveen on 03/20/18 Bhatia.
//  Copyright (c) 2018 Bhatia, Parveen. All rights reserved.


import UIKit

enum Users
{
    struct Request
    {
    }
    struct Response
    {
        var users: [UserDetails]
    }
    struct ViewModel
    {
        struct DisplayUser
        {
            var fullName: String
            var addressLine1: String
            var addressLine2: String
        }
        var displayedUsers: [DisplayUser]
    }
}




