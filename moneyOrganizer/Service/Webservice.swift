//
//  Webservice.swift
//  moneyOrganizer
//
//  Created by Sait KARACA on 17.09.2023.
//

import Foundation

public enum exchangeRateError : Error {
    case serverError
    case parsingEror
}

class Webservice {
    
    func downloadCurrencies(url: URL, completion: @escaping (Result<exchangeRate,exchangeRateError>) -> ()) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completion(.failure(.serverError))
            } else if let data = data {
                
                let exchangeRateList = try? JSONDecoder().decode(exchangeRate.self, from: data)
                
                if let exchangeRateList = exchangeRateList {
                    completion(.success(exchangeRateList))
                } else {
                    completion(.failure(.parsingEror))
                }
            }
        }.resume()
    }
}
