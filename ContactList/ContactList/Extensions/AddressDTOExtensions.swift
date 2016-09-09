//
//  AddressDTOExtensions.swift
//  ContactList
//
//  Created by Daniel Sumara on 09.09.2016.
//  Copyright © 2016 Sumara. All rights reserved.
//

import Foundation

extension AddressDTO: CustomStringConvertible {
    
    var description: String {
        return "\(self.street)\n\(self.postCode) \(self.city)\n\(self.state)"
    }
    
}
