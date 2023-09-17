//
//  exchangeRateInteractor.swift
//  moneyOrganizer
//
//  Created by Sait KARACA on 17.09.2023.
//

import Foundation

class exchangeRateInteractor : PresenterToInteractorExchangeRateProtocol {
    
    var exchangeRatePresenter : InteractorToPresenterExchangeRateProtocol?
    
    func readCurrenciesFile() {
        
        let Url = "http://data.fixer.io/api/latest?access_key=22891c4d529f0d04eeb485bf72c07d3f&symbols=USD,AUD,CAD,TRY,MXN&format=1"
        Webservice().downloadCurrencies(url: URL(string:Url)!) { exchangeRateResult in
           
            switch exchangeRateResult {
            case .success(let exchangeRate):
                //print(exchangeRate.rates)
                self.exchangeRatePresenter?.sendPresenterCurrenciesList(list: exchangeRate.rates)
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
