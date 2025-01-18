//
//  Untitled.swift
//  Prouduct List
//
//  Created by Jakaria Noman on 9/1/25.
//

import Foundation
import ReactiveSwift

enum DataError: Error {
    case invalidURL(String)
    case invalidData
    case networkError
    case network(Error?)
}

typealias Handler = (Result<[ProductInfo],DataError>) -> Void
//when we declare a class final . That's mean we can not inherit it.
final class APIManager {
    static func fetchProductList() -> SignalProducer< Result<[ProductInfo],DataError>, Never> {
        
        return SignalProducer { observer, lifetime in
            guard let url = URL(string: "https://fakestoreapi.com/products") else {
                observer.send(value: .failure(.invalidURL("Invalid URL")))
                return
            }
            
            let urlSession = URLSession.shared
            let _ = urlSession.dataTask(with: url) { data, response, error in
                
                if error != nil {
                    observer.send(value: .failure(.networkError))
                    return
                }
                
                guard let data else {
                    observer.send(value: .failure (.invalidData))
                    return
                }
                let decodeData = parseData(data:data)
                
                observer.send(value: decodeData)
                observer.sendCompleted()
                
            }.resume()
        }
    }
    
    static func parseData(data: Data) -> Result<[ProductInfo],DataError> {
        
        do {
            let decode = JSONDecoder()
            let decodeProducts = try decode.decode([ProductInfo].self, from: data)
            return .success(decodeProducts)
            
        } catch {
            return .failure(.network(error))
        }
    }
    
}
