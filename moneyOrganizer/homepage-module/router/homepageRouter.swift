//
//  homepageRouter.swift
//  moneyOrganizer
//
//  Created by Sait KARACA on 6.09.2023.
//

import Foundation

class homepageRouter : PresenterToRouterHomepageProtocol {
    
    static func createModule(ref: homepageViewController) {
        
        let presenter = homepagePresenter()
        
        // View Layer
        
        ref.presenterObject = presenter
        
        // Presenter Layer
        
        ref.presenterObject?.homepageInteractor = homepageInteractor()
        ref.presenterObject?.homepageView = ref
        
        // Interactor Layer
        
        ref.presenterObject?.homepageInteractor?.homepagePresenter = presenter
        
    }
    
}
