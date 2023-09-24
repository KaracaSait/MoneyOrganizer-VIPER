//
//  firstPagePresenter.swift
//  moneyOrganizer
//
//  Created by Sait KARACA on 24.09.2023.
//

import Foundation

class FirstPagePresenter : ViewToPresenterFirstPageProtocol {
    
    var firstPageInteractor: PresenterToInteractorFirstPageProtocol?
    
    func readDatabase() {
        firstPageInteractor?.readData()
    }
    
}

