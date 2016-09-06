//
//  ContactDTO.swift
//  ContactList
//
//  Created by Daniel Sumara on 06.09.2016.
//  Copyright © 2016 Sumara. All rights reserved.
//

import Foundation

struct ContactDTO {
    
    let name: String
    let surname: String
    
    let email: String
    
    let picture: ImageDTO
    let address: AddressDTO
    
    let phone: String
    let cell: String
    
    let isFavorite: Bool
    
}
