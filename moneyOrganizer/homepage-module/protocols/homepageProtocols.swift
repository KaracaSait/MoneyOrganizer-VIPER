//
//  homepageProtocols.swift
//  moneyOrganizer
//
//  Created by Sait KARACA on 6.09.2023.
//

import Foundation

// Main Protocols

protocol ViewToPresenterHomepageProtocol {
    
    var homepageInteractor : PresenterToInteractorHomepageProtocol? { get set }
    var homepageView : PresenterToViewHomepageProtocol? { get set }
    
    func readAccountsFile()
}

protocol PresenterToInteractorHomepageProtocol {
    
    var homepagePresenter : InteractorToPresenterHomepageProtocol? { get set }
    
    func readAccounts()
    
}

// Carrier Protocols

protocol InteractorToPresenterHomepageProtocol {
    
    func sendDataPresentar(accountList:Array<accounts>)
}

protocol PresenterToViewHomepageProtocol {
    
    func sendDataView(accountList:Array<accounts>)
}

// Authorization Protocol

protocol PresenterToRouterHomepageProtocol {
    
    static func createModule(ref:homepageViewController)
    
}
