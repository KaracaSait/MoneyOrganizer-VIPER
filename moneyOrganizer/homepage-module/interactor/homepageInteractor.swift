//
//  homepageInteractor.swift
//  moneyOrganizer
//
//  Created by Sait KARACA on 6.09.2023.
//

import Foundation

class homepageInteractor : PresenterToInteractorHomepageProtocol {
    var homepagePresenter: InteractorToPresenterHomepageProtocol?
    
    let db:FMDatabase?
    
    init() {
        
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let veriTabaniUrl = URL(filePath: hedefYol).appending(path: "wallet.sqlite")
        db = FMDatabase(path: veriTabaniUrl.path())
    }
    
    func readAccounts() {
        var list = [accounts]()
        
        db?.open()
        
        do {
            
            let rs = try db!.executeQuery("SELECT * FROM accounts", values: nil)
            
            while rs.next() {
                let part = accounts(id: Int(rs.string(forColumn: "id"))!,
                                    name: rs.string(forColumn: "name")!,
                                    picture: rs.string(forColumn: "picture")!)
               
                list.append(part)
            }
            
            homepagePresenter?.sendDataPresentar(accountList: list)
            
        } catch {
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    func accountDataRead() {
        
        var money = 0
        
        db?.open()
        
        do{
            
            let rsBank = try db!.executeQuery("SELECT * FROM bankaccount", values: nil)
            
            while rsBank.next() {
                
                let totalMoney = rsBank.string(forColumn: "price")
                if let totalMoneyInt = Int(totalMoney!) {
                    money += totalMoneyInt
                }
            }
            homepagePresenter?.sendTotalMoneyBankPresentar(totalMoney: money)
            money = 0
            
            let rsCash = try db!.executeQuery("SELECT * FROM cashaccount", values: nil)
            
            while rsCash.next() {
                
                let totalMoney = rsCash.string(forColumn: "price")
                if let totalMoneyInt = Int(totalMoney!) {
                    money += totalMoneyInt
                }
            }
            homepagePresenter?.sendTotalMoneyCashPresentar(totalMoney: money)
            money = 0
            
            let rsCredit = try db!.executeQuery("SELECT * FROM creditcard", values: nil)
            
            while rsCredit.next() {
                
                let totalMoney = rsCredit.string(forColumn: "price")
                if let totalMoneyInt = Int(totalMoney!) {
                    money += totalMoneyInt
                }
            }
            homepagePresenter?.sendTotalMoneyCreditPresentar(totalMoney: money)
            
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func readAccountDetail() {
        
        var listBank = [accountDetail]()
        var listCash = [accountDetail]()
        var listCredit = [accountDetail]()
        
        db?.open()
        
        do{
            
            let rsBank = try db!.executeQuery("SELECT * FROM bankaccount ORDER BY id DESC LIMIT 2", values: nil)
            
            while rsBank.next() {
                
                let part = accountDetail(activity: rsBank.string(forColumn: "activity"),
                                         price: rsBank.string(forColumn: "price"))
                
                listBank.append(part)
            }
            homepagePresenter?.sendBankAccountDetailPresentar(accountDetail: listBank)
            
            let rsCash = try db!.executeQuery("SELECT * FROM cashaccount ORDER BY id DESC LIMIT 2", values: nil)
            
            while rsCash.next() {
                
                let part = accountDetail(activity: rsCash.string(forColumn: "activity"),
                                         price: rsCash.string(forColumn: "price"))
                
                listCash.append(part)
            }
            homepagePresenter?.sendCashAccountDetailPresentar(accountDetail: listCash)
            
            let rsCredit = try db!.executeQuery("SELECT * FROM creditcard ORDER BY id DESC LIMIT 2", values: nil)
            
            while rsCredit.next() {
                
                let part = accountDetail(activity: rsCredit.string(forColumn: "activity"),
                                         price: rsCredit.string(forColumn: "price"))
                
                listCredit.append(part)
            }
            homepagePresenter?.sendCreditAccountDetailPresentar(accountDetail: listCredit)
            
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
}
