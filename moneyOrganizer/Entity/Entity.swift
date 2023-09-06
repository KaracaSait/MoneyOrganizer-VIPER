//
//  Entity.swift
//  moneyOrganizer
//
//  Created by Sait KARACA on 6.09.2023.
//

import Foundation

class accounts {
    var id:Int?
    var name:String?
    var picture:String?
   
    init(id: Int? = nil, name: String? = nil, picture: String? = nil) {
        self.id = id
        self.name = name
        self.picture = picture
    }
    
}

