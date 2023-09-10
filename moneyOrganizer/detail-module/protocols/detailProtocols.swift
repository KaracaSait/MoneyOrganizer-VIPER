//
//  detailProtocols.swift
//  moneyOrganizer
//
//  Created by Sait KARACA on 7.09.2023.
//

import Foundation
import UIKit

// Main Protocols

protocol ViewToPresenterDetailProtocol {
    
    var detailInteractor : PresenterToInteractorDetailProtocol? { get set }
    var detailView : PresenterToViewDetailProtocol? { get set }
    
    func dataRead (whichAccount:Int)
    
    func showAlert(title: String, message: String, whichAccount:Int)
    
}

protocol PresenterToInteractorDetailProtocol {
    
    var detailPresenter : InteractorToPresenterDetailProtocol? { get set }
    
    func accountDataRead (whichAccount:Int)
    
    func sendMoneyToInteractor(money:String, whichAccount:Int, explanation:String, date:String)
    
}

// Carrier Protocols

protocol InteractorToPresenterDetailProtocol {
    
    func sendDataPresentar(detailList:Array<accountDetail>)
    func sendTotalMoneyPresentar(totalMoney:Int)
    
}

protocol PresenterToViewDetailProtocol {
    
    func sendDataView(detailList:Array<accountDetail>)
    func sendTotalMoneyView(totalMoney:Int)
    
    func presenterAlert(_ alertController: UIAlertController)
}

// Authorization Protocol

protocol PresenterToRouterDetailProtocol {
    
    static func createModule(ref:detailViewController)
    
}

