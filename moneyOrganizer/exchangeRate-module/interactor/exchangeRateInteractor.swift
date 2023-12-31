//
//  exchangeRateInteractor.swift
//  moneyOrganizer
//
//  Created by Sait KARACA on 17.09.2023.
//

import Foundation

var sortedRatesList = [String:Double]()

class exchangeRateInteractor : PresenterToInteractorExchangeRateProtocol {
    
    var exchangeRatePresenter : InteractorToPresenterExchangeRateProtocol?
    
    func readCurrenciesFile() {
        
        let Url = "http://data.fixer.io/api/latest?access_key=22891c4d529f0d04eeb485bf72c07d3f&format=1"
        Webservice().downloadCurrencies(url: URL(string:Url)!) { exchangeRateResult in
           
            switch exchangeRateResult {
            case .success(let exchangeRate):
                let sortedRates = exchangeRate.rates.sorted(by: { $0.key < $1.key })
                self.exchangeRatePresenter?.sendPresenterCurrenciesList(list: sortedRates)
            case .failure(let failure):
                switch failure {
                case .parsingEror:
                    print("parsing error")
                case .serverError:
                    print("server error")
                }
            }
        }
        
        
    }
    
}
