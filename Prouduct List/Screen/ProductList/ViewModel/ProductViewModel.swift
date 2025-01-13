//
//  Untitled.swift
//  Prouduct List
//
//  Created by Jakaria Noman on 10/1/25.
//

import Foundation

final class ProductViewModel {
    var products : [ProductInfo] = .init()
    var eventHandler : ((_ event: Event) -> Void)?
    
    func fetchProduct () {
        eventHandler?(.loadding)
        APIManager.fetchProductData { [weak self] result in
            
            guard let self else { return }
            eventHandler?(.stopLoading)
            switch  result {
            case .success(let productInfo):
                self.products = productInfo
                eventHandler?(.dataLoaded)
            case .failure(let error):
                eventHandler?(.error(error))
            }
        }
    }
}

extension ProductViewModel {
    enum Event {
        case loadding
        case stopLoading
        case dataLoaded
        case error(Error?)
    }
}
