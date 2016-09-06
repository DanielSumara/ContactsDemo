//
//  ContactsFactory.swift
//  ContactList
//
//  Created by Daniel Sumara on 06.09.2016.
//  Copyright © 2016 Sumara. All rights reserved.
//

import Foundation

class ContactsFactory {
    
    func getContactsFrom(data: NSData) -> [ContactDTO] {
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as! [String: AnyObject]
            let result: [[String: AnyObject]] = json["results"] as! [[String: AnyObject]]
            return result.map { contactFrom($0) }
        }
        catch {
            return []
        }
    }
    
    private func contactFrom(json: [String: AnyObject]) -> ContactDTO {
        let nameDictionary = json["name"] as! [String: AnyObject]
        let firstName: String = nameDictionary["first"] as! String
        let lastName: String = nameDictionary["last"] as! String
        let email: String = json["email"] as! String
        let picture: ImageDTO = imageFrom(json["picture"] as! [String: AnyObject])
        let address: AddressDTO = addressFrom(json["location"] as! [String: AnyObject])
        let phoneNo: String = json["phone"] as! String
        let cellNo: String = json["cell"] as! String
        
        return ContactDTO(name: firstName,
                          surname: lastName,
                          email: email,
                          picture: picture,
                          address: address,
                          phone: phoneNo,
                          cell: cellNo,
                          isFavorite: false)
        
    }
    
    private func imageFrom(json: [String: AnyObject]) -> ImageDTO {
        let thumbnailUrl: String = json["thumbnail"] as! String
        let largeUrl: String = json["large"] as! String
        
        return ImageDTO(thumbnailUrl: thumbnailUrl, largeUrl: largeUrl)
    }
    
    private func addressFrom(json: [String: AnyObject]) -> AddressDTO {
        let street: String = json["street"] as! String
        let city: String = json["city"] as! String
        let state: String = json["state"] as! String
        let postCode: String = (json["postcode"] as! NSNumber).description
        
        return AddressDTO(street: street, city: city, state: state, postCode: postCode)
    }
    
}
