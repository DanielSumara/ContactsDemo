//
//  CellViewModel.swift
//  ContactList
//
//  Created by Daniel Sumara on 06.09.2016.
//  Copyright © 2016 Sumara. All rights reserved.
//

import UIKit

protocol ContactCellViewModelProtocol {
    
    var firstName: String { get }
    var lastName: String { get }
    var thumbnail: UIImage? { get }
    
}

struct ContactCellViewModel: ContactCellViewModelProtocol {
    
    let firstName: String
    let lastName: String
    let thumbnail: UIImage?
    
    init(from contact: ContactDTO) {
        self.firstName = contact.name
        self.lastName = contact.surname
        self.thumbnail = nil
    }
    
}
