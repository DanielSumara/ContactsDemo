//
//  ErrorUtils.swift
//  ContactList
//
//  Created by Daniel Sumara on 06.09.2016.
//  Copyright © 2016 Sumara. All rights reserved.
//

import Foundation

class ErrorUtils {
    
    // MARK: - Properties
    
    private static let Domain: String = "com.sumara.ContactList"
    
    // MARK: - API
    
    func getBadUrlError() -> NSError {
        let localizedDestription: String = "Cannot create url"
        let localizedFailureReason: String = localizedDestription
        
        let error = NSError(domain: ErrorUtils.Domain, code: 601, userInfo: [
            NSLocalizedDescriptionKey: localizedDestription,
            NSLocalizedFailureReasonErrorKey: localizedFailureReason
        ])
        
        return error
    }
    
    func getBadHttpStatusCode(statusCode: Int) -> NSError {
        let localizedDestription: String = "Http status code has unexpected value: \(statusCode)"
        let localizedFailureReason: String = localizedDestription
        
        let error = NSError(domain: ErrorUtils.Domain, code: 602, userInfo: [
            NSLocalizedDescriptionKey: localizedDestription,
            NSLocalizedFailureReasonErrorKey: localizedFailureReason
            ])
        
        return error
    }
    
    func getLackOfDataInResponse() -> NSError {
        let localizedDestription: String = "Lack of data in response"
        let localizedFailureReason: String = localizedDestription
        
        let error = NSError(domain: ErrorUtils.Domain, code: 603, userInfo: [
            NSLocalizedDescriptionKey: localizedDestription,
            NSLocalizedFailureReasonErrorKey: localizedFailureReason
            ])
        
        return error
    }
    
}
