//
//  CellViewModel.swift
//  ContactList
//
//  Created by Daniel Sumara on 06.09.2016.
//  Copyright © 2016 Sumara. All rights reserved.
//

import UIKit

protocol ContactCellViewModelProtocol: class {
    
    weak var parentCell: ContactTableViewCell? { get set }
    var isScrolling: Bool { get set }
    
}

class ContactCellViewModel: ContactCellViewModelProtocol, Comparable {
    
    // MARK: - Properties
    
    weak var parentCell: ContactTableViewCell? {
        didSet {
            updateCell()
            getThumbnail()
        }
    }
    
    var isScrolling: Bool = false {
        didSet {
            getThumbnail()
        }
    }
    
    let firstName: String
    let lastName: String
    let thumbnailUrl: String
    private(set) var thumbnailImage: UIImage?
    
    private let imageRepository: ImageRepositoryProtocol
    
    // MARK: - Lifecicle
    
    init(from contact: ContactDTO, imageRepository: ImageRepositoryProtocol) {
        self.imageRepository = imageRepository
        
        self.firstName = contact.name
        self.lastName = contact.surname
        self.thumbnailUrl = contact.picture.thumbnailUrl
    }
    
    // MARK: - Methods
    
    private func updateCell() {
        guard let cell = self.parentCell else {
            return
        }
        
        cell.nameLabel.text = self.firstName
        cell.surnameLabel.text = self.lastName
        cell.thumbnail.image = self.thumbnailImage
    }
    
    private func getThumbnail() {
        guard (self.parentCell != nil) else { return }
        guard (self.thumbnailImage == nil) else { return }
        guard (!self.isScrolling) else { return }
        
        self.imageRepository.getImageFrom(self.thumbnailUrl) { [weak self] result in
            switch (result) {
            case .Success(let (_, image)): self?.setImageAndRefreshCell(image)
            case .Failure(_): // TODO: Delegate error presentation to viewController
                break
            }
        }
    }
    
    private func setImageAndRefreshCell(image: UIImage) {
        self.thumbnailImage = image
        updateCell()
    }
    
    // TODO: - DRY
    private func delay(delay: Double, closure: () -> Void) {
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
        dispatch_after(time, dispatch_get_main_queue(), closure)
    }
    
}

func ==(lhs: ContactCellViewModel, rhs: ContactCellViewModel) -> Bool {
    return lhs.firstName == rhs.firstName && lhs.lastName == rhs.lastName
}

func <(lhs: ContactCellViewModel, rhs: ContactCellViewModel) -> Bool {
    if (lhs.lastName == rhs.lastName) {
        return lhs.firstName < rhs.firstName
    }
    return lhs.lastName < rhs.lastName
}
