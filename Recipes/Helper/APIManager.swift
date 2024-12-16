//
//  APIManager.swift
//  Recipes
//
//  Created by Amey Kanunje on 12/15/24.
//

import Foundation

protocol APIManagerProtocol{
    func request<T: Decodable>(
        modelType: T.Type,
        type: EndpointType
    ) async throws -> T
}

class APIManager: APIManagerProtocol {
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(modelType: T.Type, type: EndpointType) async throws -> T {
        guard let url = type.url else {
            throw DataError.invalidURL
        }
        
        do {
            let (data, response) = try await session.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode >= 200 && httpResponse.statusCode <= 300 else {
                throw DataError.invalidResponse
            }
            
            let decodedData = try JSONDecoder().decode(modelType, from: data)
            return decodedData
        } catch {
            throw DataError.network(error)
        }
    }
}



enum DataError: Error{
    case invalidURL
    case invalidData
    case invalidResponse
    case network(Error?)
    case networkError(String)
}
