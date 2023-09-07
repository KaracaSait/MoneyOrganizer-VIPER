//
//  detailPresenter.swift
//  moneyOrganizer
//
//  Created by Sait KARACA on 7.09.2023.
//

import Foundation

class detailPresenter : ViewToPresenterDetailProtocol {
    
    var detailView: PresenterToViewDetailProtocol?
    var detailInteractor: PresenterToInteractorDetailProtocol?
    
    func dataRead(whichAccount:Int) {
        
        detailInteractor?.accountDataRead(whichAccount: whichAccount)
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
