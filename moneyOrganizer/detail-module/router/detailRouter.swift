//
//  detailRouter.swift
//  moneyOrganizer
//
//  Created by Sait KARACA on 7.09.2023.
//

import Foundation

class detailRouter : PresenterToRouterDetailProtocol {
    
    static func createModule(ref: detailViewController) {
        
        let presenter = detailPresenter()
        
        // View Layer
        
        ref.detailPresenterObject = presenter
        
        // Presenter Layer
        
        ref.detailPresenterObject?.detailInteractor = detailInteractor()
        ref.detailPresenterObject?.detailView = ref
        
        // Interactor Layer
        
        ref.detailPresenterObject?.detailInteractor?.detailPresenter = presenter
        
    }
    
}
