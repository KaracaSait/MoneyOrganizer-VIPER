//
//  firstPageRouter.swift
//  moneyOrganizer
//
//  Created by Sait KARACA on 24.09.2023.
//

import Foundation

class FirstPageRouter : PresenterToRouterFirstPageProtocol {
    
    static func createModule(ref: firstPageViewController) {
        
        // View Layer
        
        ref.presenterObject = FirstPagePresenter()
        
        // Presenter Layer
        
        ref.presenterObject?.firstPageInteractor = FirstPageInteractor()
        
    }
    
}
