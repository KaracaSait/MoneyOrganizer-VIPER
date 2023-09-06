//
//  homepagePresenter.swift
//  moneyOrganizer
//
//  Created by Sait KARACA on 6.09.2023.
//

import Foundation

class homepagePresenter : ViewToPresenterHomepageProtocol {
    
    var homepageView: PresenterToViewHomepageProtocol?
    var homepageInteractor: PresenterToInteractorHomepageProtocol?
    
    func readAccountsFile() {
        homepageInteractor?.readAccounts()
    }
    
}


extension homepagePresenter : InteractorToPresenterHomepageProtocol {
    
    func sendDataPresentar(accountList: Array<accounts>) {
        homepageView?.sendDataView(accountList: accountList)
    }
    
}
