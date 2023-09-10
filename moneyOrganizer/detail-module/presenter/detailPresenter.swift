//
//  detailPresenter.swift
//  moneyOrganizer
//
//  Created by Sait KARACA on 7.09.2023.
//

import Foundation
import UIKit

class detailPresenter : ViewToPresenterDetailProtocol {
    
    var detailView: PresenterToViewDetailProtocol?
    var detailInteractor: PresenterToInteractorDetailProtocol?
    
    func dataRead(whichAccount:Int) {
        
        detailInteractor?.accountDataRead(whichAccount: whichAccount)
    }
    
    func showAlert(title: String, message: String, whichAccount:Int) {
        
        let yil = Calendar.current.component(.year, from: Date())
        let ay = Calendar.current.component(.month, from: Date())
        let gun = Calendar.current.component(.day, from: Date())
        let tarih = "\(gun)/\(ay)/\(yil)"
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
        alertController.addTextField { textfield in
            textfield.placeholder = "$"
            textfield.keyboardType = .numberPad
        }
        alertController.addTextField { textfield in
            textfield.placeholder = "Explanation"
            textfield.keyboardType = .default
        }
        let okAction = UIAlertAction(title: "Add", style: .destructive){ action in
            if let money = alertController.textFields![0].text, !money.isEmpty {
                if let explanation = alertController.textFields![1].text, !explanation.isEmpty {
                    self.detailInteractor?.sendMoneyToInteractor(money: money, whichAccount: whichAccount, explanation: explanation,date: tarih)
                } else {
                    self.detailInteractor?.sendMoneyToInteractor(money: money, whichAccount: whichAccount, explanation: " -",date: tarih)
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        detailView?.presenterAlert(alertController)
        }
    
}

extension detailPresenter : InteractorToPresenterDetailProtocol {
    
    func sendDataPresentar(detailList:Array<accountDetail>) {
        detailView?.sendDataView(detailList: detailList)
    }
    
    func sendTotalMoneyPresentar(totalMoney: Int) {
        detailView?.sendTotalMoneyView(totalMoney: totalMoney)
    }
    
    
}
