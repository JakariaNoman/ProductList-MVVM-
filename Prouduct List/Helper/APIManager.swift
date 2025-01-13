//
//  Untitled.swift
//  Prouduct List
//
//  Created by Jakaria Noman on 9/1/25.
//

import Foundation

enum DataError: Error {
    case invalideURL
    case invalidData
    case networkError
    case network(Error?)
}
typealias Handler = (Result<[ProductInfo],DataError>) -> Void
//when we declare a class final . That's mean we can not inherit it.

final class APIManager {
    static func fetchProductData(completion: @escaping Handler) {
        //create url
        guard let url = URL(string: "https://fakestoreapi.com/products") else {
            completion(.failure(.invalideURL))
            return
        }
        //create a urlsession
        let urlSession = URLSession(configuration: .default)
        // give the session a task
        urlSession.dataTask(with: url) { data ,urlResponse,error in
            guard let data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            parseData(data: data, completion: completion)
        }.resume()
    }
}

func parseData(data: Data, completion: @escaping Handler) {
    
    do {
        let decodeProductData = try JSONDecoder().decode([ProductInfo].self, from: data)
        completion(.success(decodeProductData))
    }catch {
        completion(.failure(.network(error)))
    }
}
