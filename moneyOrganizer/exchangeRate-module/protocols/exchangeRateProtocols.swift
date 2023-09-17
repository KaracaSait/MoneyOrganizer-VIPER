//
//  exchangeRateProtocols.swift
//  moneyOrganizer
//
//  Created by Sait KARACA on 17.09.2023.
//

import Foundation

// Main Protocols

protocol ViewToPresenterExchangeRateProtocol {
    
    var exchangeRateInteractor : PresenterToInteractorExchangeRateProtocol? { get set }
    var exchangeRateView : PresenterToViewExchangeRateProtocol? { get set }
    
    func readCurrencies()
}

protocol PresenterToInteractorExchangeRateProtocol {
    
    var exchangeRatePresenter : InteractorToPresenterExchangeRateProtocol? { get set }
    
    func readCurrenciesFile()
}

// Carrier Protocols

protocol InteractorToPresenterExchangeRateProtocol {
    
    func sendPresenterCurrenciesList(list:[String : Double])
    
}

protocol PresenterToViewExchangeRateProtocol {
   
    func sendViewCurrenciesList(list:[String : Double])
    
}

// Authorization Protocol

protocol PresenterToRouterExchangeRateProtocol {
    
    static func createModule(ref:exchangeRateViewController)
    
}

