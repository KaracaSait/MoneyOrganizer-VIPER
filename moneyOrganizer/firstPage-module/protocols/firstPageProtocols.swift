//
//  firstPageProtocols.swift
//  moneyOrganizer
//
//  Created by Sait KARACA on 24.09.2023.
//

import Foundation

// Main Protocols

protocol ViewToPresenterFirstPageProtocol {
    
    var firstPageInteractor : PresenterToInteractorFirstPageProtocol? { get set }
    
    func readDatabase()
    
}

protocol PresenterToInteractorFirstPageProtocol {
    
    func readData()
}

// Authorization Protocol

protocol PresenterToRouterFirstPageProtocol {
    
    static func createModule(ref:firstPageViewController)
    
}
