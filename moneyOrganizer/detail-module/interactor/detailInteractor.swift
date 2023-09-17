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
        var money = 0
        
        db?.open()
        
        do {
            
            switch whichAccount {
            case 1:
                rs = try db!.executeQuery("SELECT * FROM bankaccount ORDER BY id DESC", values: nil)
            case 2:
                rs = try db!.executeQuery("SELECT * FROM cashaccount ORDER BY id DESC", values: nil)
            case 3:
                rs = try db!.executeQuery("SELECT * FROM creditcard ORDER BY id DESC", values: nil)
            default: break
            }
            
            if let rs = rs {
                
                while rs.next() {
                    
                    let part = accountDetail(id: Int(rs.string(forColumn: "id"))!,
                                             activity: rs.string(forColumn: "activity"),
                                             price: rs.string(forColumn: "price"),
                                             date: rs.string(forColumn: "date"))
                    list.append(part)
                    
                    let totalMoney = rs.string(forColumn: "price")
                    if let totalMoneyInt = Int(totalMoney!) {
                        money += totalMoneyInt
                    }
                    
                }
            }
            detailPresenter?.sendTotalMoneyPresentar(totalMoney: money)
            detailPresenter?.sendDataPresentar(detailList: list)
            
        } catch {
            print(error.localizedDescription)
        }
        db?.close()
        
    }
    
    func sendMoneyToInteractor(money: String, whichAccount: Int, explanation: String, date: String) {
        
        db?.open()
        
        do {
            if UserDefaults.standard.string(forKey: "process") == "plus" {
                switch whichAccount {
                    case 1:
                        try db!.executeUpdate("INSERT INTO bankaccount (price,activity,date) VALUES (?,?,?)", values: ["+" + money, explanation, date])
                    case 2:
                        try db!.executeUpdate("INSERT INTO cashaccount (price,activity,date) VALUES (?,?,?)", values: ["+" + money, explanation, date])
                    case 3:
                        try db!.executeUpdate("INSERT INTO creditcard (price,activity,date) VALUES (?,?,?)", values: ["+" + money, explanation, date])
                    default: break
                    
                }
            }else if UserDefaults.standard.string(forKey: "process") == "minus" {
                switch whichAccount {
                    case 1:
                        try db!.executeUpdate("INSERT INTO bankaccount (price,activity,date) VALUES (?,?,?)", values: ["-" + money, explanation, date])
                    case 2:
                        try db!.executeUpdate("INSERT INTO cashaccount (price,activity,date) VALUES (?,?,?)", values: ["-" + money, explanation, date])
                    case 3:
                        try db!.executeUpdate("INSERT INTO creditcard (price,activity,date) VALUES (?,?,?)", values: ["-" + money, explanation, date])
                    default: break
                }
            }
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
        accountDataRead(whichAccount: whichAccount)
    }
    
    func accountDataDel(id: Int, whichAccount: Int) {
        db?.open()
        
        do {
            switch whichAccount {
            case 1:
                try db?.executeUpdate("DELETE FROM bankaccount WHERE id = ?", values: [id])
            case 2:
                try db?.executeUpdate("DELETE FROM cashaccount WHERE id = ?", values: [id])
            case 3:
                try db?.executeUpdate("DELETE FROM creditcard WHERE id = ?", values: [id])
            default: break
            }
        }catch{
            print(error.localizedDescription)
        }
        accountDataRead(whichAccount: whichAccount)
        db?.close()
    }
    
    func accountRecentActivities(whichAccount: Int) {
        db?.open()
        
        do {
            
            switch whichAccount {
            case 1:
                rs = try db!.executeQuery("SELECT * FROM bankaccount ORDER BY id DESC LIMIT 1", values: nil)
            case 2:
                rs = try db!.executeQuery("SELECT * FROM cashaccount ORDER BY id DESC LIMIT 1", values: nil)
            case 3:
                rs = try db!.executeQuery("SELECT * FROM creditcard ORDER BY id DESC LIMIT 1", values: nil)
            default: break
            }
            
            if let rs = rs {
                
                if rs.next() {
                    let recentActivities = rs.string(forColumn: "price")
                    detailPresenter?.sendRecentActivitiesPresentar(recentActivities: recentActivities! + " €")
                } else {
                    detailPresenter?.sendRecentActivitiesPresentar(recentActivities: "No Action")
                }
            }
            
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
}
