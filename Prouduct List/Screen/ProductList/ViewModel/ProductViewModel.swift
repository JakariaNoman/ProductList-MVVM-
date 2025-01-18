//
//  Untitled.swift
//  Prouduct List
//
//  Created by Jakaria Noman on 10/1/25.
//

import Foundation
import ReactiveSwift

final class ProductViewModel {
    var products : [ProductInfo] = []
    var eventHandler : ((_ event: Event) -> Void)?
    
    func fetchProduct () {
        eventHandler?(.loadding)
        
        APIManager.fetchProductList().startWithResult { [weak self] result in
            
            guard let self else { return }
            eventHandler?(.stopLoading)
            
            switch result {
            case .success(let innerResult):
                switch innerResult {
                case .success(let products):
                    DispatchQueue.main.async {
                        self.products = products
                    }
                case .failure(let error):
                    eventHandler?(.error(error))
                }
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
