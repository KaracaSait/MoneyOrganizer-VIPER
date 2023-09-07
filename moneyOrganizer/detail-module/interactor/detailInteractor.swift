//
//  detailInteractor.swift
//  moneyOrganizer
//
//  Created by Sait KARACA on 7.09.2023.
//

import Foundation

class detailInteractor : PresenterToInteractorDetailProtocol {
    var detailPresenter: InteractorToPresenterDetailProtocol?
    
    let db:FMDatabase?
    var rs:FMResultSet?
    
    init() {
        
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let veriTabaniUrl = URL(filePath: hedefYol).appending(path: "wallet.sqlite")
        db = FMDatabase(path: veriTabaniUrl.path())
    }
    
    func accountDataRead(whichAccount:Int) {
        
        var list = [accountDetail]()
        let totalMoney = [String]()
        var total = 0
        
        db?.open()
        
        do {
            
            switch whichAccount {
            case 1:
                rs = try db!.executeQuery("SELECT * FROM bankaccount", values: nil)
            case 2:
                rs = try db!.executeQuery("SELECT * FROM cashaccount", values: nil)
            case 3:
                rs = try db!.executeQuery("SELECT * FROM creditcard", values: nil)
            default: break
            }
            
            if let rs = rs {
                
                while rs.next() {
                    
                    let part = accountDetail(id: Int(rs.string(forColumn: "id"))!,
                                             activity: rs.string(forColumn: "activity")!,
                                             price: rs.string(forColumn: "price")!,
                                             date: rs.string(forColumn: "date")!)
                    
                    list.append(part)
                    
                    // --> Total Money Calculate
                    
                    let money = accountDetail(price: rs.string(forColumn: "price")!)
                    list.append(money)
                    
                    for str in totalMoney {
                        if let intValue = Int(str) {
                            total += intValue
                        }
                    }
                    
                    
                    
                }
            }
            detailPresenter?.sendTotalMoneyPresentar(totalMoney: total)
            detailPresenter?.sendDataPresentar(detailList: list)
            
        } catch {
            print(error.localizedDescription)
        }
        db?.close()
        
    }
}
