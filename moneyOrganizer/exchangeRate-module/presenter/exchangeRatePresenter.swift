//
//  exchangeRatePresenter.swift
//  moneyOrganizer
//
//  Created by Sait KARACA on 17.09.2023.
//

import Foundation

class exchangeRatePresenter: ViewToPresenterExchangeRateProtocol {
    
    var exchangeRateView: PresenterToViewExchangeRateProtocol?
    var exchangeRateInteractor: PresenterToInteractorExchangeRateProtocol?
    
    func readCurrencies() {
        exchangeRateInteractor?.readCurrenciesFile()
    }
}

extension exchangeRatePresenter : InteractorToPresenterExchangeRateProtocol {
    
    func sendPresenterCurrenciesList(list:[Dictionary<String, Double>.Element]) {
        exchangeRateView?.sendViewCurrenciesList(list: list)
    }
    
}
