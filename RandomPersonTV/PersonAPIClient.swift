//
//  PersonAPIClient.swift
//  RandomPersonTV
//
//  Created by Brendon Crowe on 5/18/23.
//

import UIKit

enum APIClientError: LocalizedError {
    case badURL
    case badResponse
    case badImageData
}

struct PersonAPIClient {
    
    static public func fetchPeople() async throws -> Data {
        let apiEndpoint = "https://randomuser.me/api/?results=25"
        guard let url = URL(string: apiEndpoint) else { throw APIClientError.badURL }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw APIClientError.badResponse
        }
        return data
    }
    
    static public func fetchPhoto(_ url: String) async throws -> UIImage {
        let endpoint = url
        guard let url = URL(string: endpoint) else { throw APIClientError.badURL }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw APIClientError.badResponse
        }
        guard let image = UIImage(data: data) else {
            throw APIClientError.badImageData
        }
        return image
    }
}
