//
//  UserDetails.swift
//  CleanSwiftSample
//
//  Created by Parveen Bhatia on 3/26/18.
//

import Foundation

struct UserDetails: Codable {
    let id: Int
    let fullName: String?
    let username: String?
    let email: String?
    let phone: String?
    let website: String?
    let userAddress: Address?
    let company: Company?
    
    enum CodingKeys: String, CodingKey {
        case fullName = "name"
        case id
        case username
        case email
        case phone
        case website
        case userAddress = "address"
        case company
    }
}

struct Company: Codable {
    let name: String
    let catchPhrase: String?
    let bs: String?
}

struct Address: Codable {
    let street: String?
    let suite: String?
    let city: String?
    let zipcode: String
    let geo: Coordinates?
}

struct Coordinates: Codable {
    let lat: String
    let lng: String
}
