//
//  ContactDTO.swift
//  ContactList
//
//  Created by Daniel Sumara on 06.09.2016.
//  Copyright © 2016 Sumara. All rights reserved.
//

import Foundation

class ContactDTO {
    
    let name: String
    let surname: String
    
    let email: String
    
    let picture: ImageDTO
    let address: AddressDTO
    
    let phone: String
    let cell: String
    
    var isFavorite: Bool
    
    init(name: String,
         surname: String,
         email: String,
         picture: ImageDTO,
         address: AddressDTO,
         phone: String,
         cell: String,
         isFavorite: Bool) {
        self.name = name
        self.surname = surname
        self.email = email
        self.picture = picture
        self.address = address
        self.phone = phone
        self.cell = cell
        self.isFavorite = isFavorite
    }
    
}
