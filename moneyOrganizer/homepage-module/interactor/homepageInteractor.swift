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
    
}
