//
//  ServiceResult.swift
//  ContactList
//
//  Created by Daniel Sumara on 06.09.2016.
//  Copyright © 2016 Sumara. All rights reserved.
//

import Foundation

enum ServiceResult <DataType> {
    case Success(DataType)
    case Failure(NSError)
}
