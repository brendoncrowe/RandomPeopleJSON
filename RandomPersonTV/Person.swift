//
//  Person.swift
//  RandomPersonTV
//
//  Created by Brendon Crowe on 5/18/23.
//

import Foundation


struct PeopleResults: Decodable {
    let results: [Person]
}

struct Person: Decodable {
    let name: Name
    let picture: Picture
}

struct Name: Decodable {
    let first: String
    let last: String
}

struct Picture: Decodable {
    let medium: String
    let large: String
}
