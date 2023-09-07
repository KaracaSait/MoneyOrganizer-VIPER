//
//  detailProtocols.swift
//  moneyOrganizer
//
//  Created by Sait KARACA on 7.09.2023.
//

import Foundation

// Main Protocols

protocol ViewToPresenterDetailProtocol {
    
    var detailInteractor : PresenterToInteractorDetailProtocol? { get set }
    var detailView : PresenterToViewDetailProtocol? { get set }
    
    func dataRead (whichAccount:Int)
    
}

protocol PresenterToInteractorDetailProtocol {
    
    var detailPresenter : InteractorToPresenterDetailProtocol? { get set }
    
    func accountDataRead (whichAccount:Int)
    
}

// Carrier Protocols

protocol InteractorToPresenterDetailProtocol {
    
    //func sendDataPresentar(accountList:Array<accounts>)
    func sendDataPresentar(detailList:Array<accountDetail>)
    func sendTotalMoneyPresentar(totalMoney:Int)
}

protocol PresenterToViewDetailProtocol {
    
    //func sendDataView(accountList:Array<accounts>)
    func sendDataView(detailList:Array<accountDetail>)
    func sendTotalMoneyView(totalMoney:Int)
}

// Authorization Protocol

protocol PresenterToRouterDetailProtocol {
    
    static func createModule(ref:detailViewController)
    
}

