//
//  DataManager.swift
//  ContactList
//
//  Created by Daniel Sumara on 06.09.2016.
//  Copyright © 2016 Sumara. All rights reserved.
//

import Foundation

protocol DataManagerProtocol {
    
    func getContacts(resultBlock: (ServiceResult<[ContactDTO]>) -> Void)
    
}

class DataManager: DataManagerProtocol {
    
    // MARK: - Properties
    
    private let errorUtils = ErrorUtils()
    private let contactsFactory = ContactsFactory()  // Sholuld be injected
    private let session: NSURLSession = NSURLSession.sharedSession()
    
    // MARK: - API
    
    func getContacts(resultBlock: (ServiceResult<[ContactDTO]>) -> Void) {
        guard let url = NSURL(string: "http://api.randomuser.me/?results=5&key=0A4F-FC2E-5C76-5678&seed=rekrutacja2016") else {
            resultBlock(ServiceResult.Failure(self.errorUtils.getBadUrlError()))
            return
        }
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = UrlMethod.GET.rawValue
        let task = self.session.dataTaskWithRequest(request) { [unowned self] (data: NSData?, response: NSURLResponse?, error: NSError?) in
            if let error = error {
                resultBlock(ServiceResult.Failure(error))
            }
            
            if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    resultBlock(ServiceResult.Failure(self.errorUtils.getBadHttpStatusCode(httpResponse.statusCode)))
                }
                else {
                    if let data = data {
                        resultBlock(ServiceResult.Success(self.contactsFactory.getContactsFrom(data)))
                    }
                    else {
                        resultBlock(ServiceResult.Failure(self.errorUtils.getLackOfDataInResponse()))
                    }
                }
            }
        }
        task.resume()
    }
    
    // MARK: - Methods
    
    
    
}
