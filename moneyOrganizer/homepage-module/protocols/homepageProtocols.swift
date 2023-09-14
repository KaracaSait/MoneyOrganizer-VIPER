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
    
    func dataRead()
    
    func readAccountDetailFile()
}

protocol PresenterToInteractorHomepageProtocol {
    
    var homepagePresenter : InteractorToPresenterHomepageProtocol? { get set }
    
    func readAccounts()
    
    func accountDataRead()
    
    func readAccountDetail()
    
}

// Carrier Protocols

protocol InteractorToPresenterHomepageProtocol {
    
    func sendDataPresentar(accountList:Array<accounts>)
    func sendBankAccountDetailPresentar(accountDetail:Array<accountDetail>)
    func sendCashAccountDetailPresentar(accountDetail:Array<accountDetail>)
    func sendCreditAccountDetailPresentar(accountDetail:Array<accountDetail>)
    func sendTotalMoneyBankPresentar(totalMoney:Int)
    func sendTotalMoneyCashPresentar(totalMoney:Int)
    func sendTotalMoneyCreditPresentar(totalMoney:Int)
}

protocol PresenterToViewHomepageProtocol {
    
    func sendDataView(accountList:Array<accounts>)
    func sendBankAccountDetailView(accountDetail:Array<accountDetail>)
    func sendCashAccountDetailView(accountDetail:Array<accountDetail>)
    func sendCreditAccountDetailView(accountDetail:Array<accountDetail>)
    func sendTotalMoneyBankView(totalMoney:Int)
    func sendTotalMoneyCashView(totalMoney:Int)
    func sendTotalMoneyCreditView(totalMoney:Int)
}

// Authorization Protocol

protocol PresenterToRouterHomepageProtocol {
    
    static func createModule(ref:homepageViewController)
    
}
