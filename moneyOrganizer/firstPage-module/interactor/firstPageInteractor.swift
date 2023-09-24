//
//  firstPageInteractor.swift
//  moneyOrganizer
//
//  Created by Sait KARACA on 24.09.2023.
//

import Foundation

class FirstPageInteractor : PresenterToInteractorFirstPageProtocol {
    
    func readData() {
        
        let bundlePath = Bundle.main.path(forResource: "wallet", ofType: ".sqlite")
        let targetPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let fileManager = FileManager.default
        let copyLocation = URL(fileURLWithPath: targetPath).appendingPathComponent("wallet.sqlite")
        if fileManager.fileExists(atPath: copyLocation.path){
            print("Database already exists")
        }else{
            do{
                try fileManager.copyItem(atPath: bundlePath!, toPath: copyLocation.path)
            }catch{}
        }
        
    }
}
