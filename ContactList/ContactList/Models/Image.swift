//
//  Image.swift
//  ContactList
//
//  Created by Daniel Sumara on 07.09.2016.
//  Copyright © 2016 Sumara. All rights reserved.
//

import UIKit

class Image {
    
    // MARK: - Properties
    
    let imageUrl: String
    
    private(set) var isDownloading: Bool
    private(set) var isInMemory: Bool
    
    private(set) var image: UIImage?
    
    // MARK: - Lifecicle
    
    init(url: String) {
        self.imageUrl = url
        self.isInMemory = false
        self.isDownloading = true
    }
    
    init(urlFromMemory: String) {
        self.imageUrl = urlFromMemory
        self.isInMemory = true
        self.isDownloading = false
    }
    
    init(url: String, image: UIImage) {
        self.imageUrl = url
        self.image = image
        
        self.isDownloading = false
        self.isInMemory = true
    }
    
}
