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
        return createErrorWith(601, andDescription: "Cannot create url")
    }
    
    func getBadHttpStatusCode(statusCode: Int) -> NSError {
        return createErrorWith(602, andDescription: "Http status code has unexpected value: \(statusCode)")
    }
    
    func getLackOfDataInResponse() -> NSError {
        return createErrorWith(603, andDescription: "Lack of data in response")
    }
    
    func getInvalidImageInMemoryError() -> NSError {
        return createErrorWith(604, andDescription: "Invalid image in memory")
    }
    
    func getInvalidDataFromNetworkError() -> NSError {
        return createErrorWith(605, andDescription: "Invalid image data from network")
    }
    
    // MARK: - Methods
    
    private func createErrorWith(code: Int, andDescription description: String) -> NSError {
        let localizedDestription: String = description
        let localizedFailureReason: String = localizedDestription
        
        let error = NSError(domain: ErrorUtils.Domain, code: code, userInfo: [
            NSLocalizedDescriptionKey: localizedDestription,
            NSLocalizedFailureReasonErrorKey: localizedFailureReason
        ])
        
        return error
    }
    
}
