//
//  exchangeRateRouter.swift
//  moneyOrganizer
//
//  Created by Sait KARACA on 17.09.2023.
//

import Foundation

class exchangeRateRouter : PresenterToRouterExchangeRateProtocol {
    
    static func createModule(ref: exchangeRateViewController) {
        
        let presenter = exchangeRatePresenter()
        
        // View Layer
        
        ref.exchangeRatePresenterObject = presenter
        
        // Presenter Layer
        
        ref.exchangeRatePresenterObject?.exchangeRateInteractor = exchangeRateInteractor()
        ref.exchangeRatePresenterObject?.exchangeRateView = ref
        
        // Interactor Layer
        
        ref.exchangeRatePresenterObject?.exchangeRateInteractor?.exchangeRatePresenter = presenter
        
    }
}
