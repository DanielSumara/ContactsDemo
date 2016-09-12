//
//  DetailsViewModel.swift
//  ContactList
//
//  Created by Daniel Sumara on 09.09.2016.
//  Copyright © 2016 Sumara. All rights reserved.
//

import UIKit

protocol DetailsViewModelProtocol {
    
    weak var parentViewController: DetailViewController? { get set }
    
    func updateView()
    func changeFavoriteState()
    
}

class DetailsViewModel: DetailsViewModelProtocol {
    
    // MARK: - Properties
    
    weak var parentViewController: DetailViewController? {
        didSet {
            updateView()
        }
    }
    
    private let imageRepository: ImageRepositoryProtocol
    
    let contact: ContactDTO
    
    private let firstName: String
    private let lastName: String
    private let email: String
    private let address: String
    private let phoneNumber: String
    private let cellNumber: String
    private var photo: UIImage?
    
    // MARK: - Lifecicle
    
    init(contact: ContactDTO, imageRepository: ImageRepositoryProtocol) {
        self.contact = contact
        self.imageRepository = imageRepository
        
        self.firstName = contact.name
        self.lastName = contact.surname
        self.email = contact.email
        self.address = contact.address.description
        self.phoneNumber = contact.phone
        self.cellNumber = contact.cell
        
        self.imageRepository.getImageFrom(contact.picture.largeUrl) { [weak self] result in
            switch (result) {
            case .Failure(let error): self?.parentViewController?.presentError(error)
            case .Success(let (_, image)):
                self?.photo = image
                self?.updateView()
            }
        }
    }
    
    // MARK: - API
    
    func updateView() {
        guard (self.parentViewController?.isViewLoaded() ?? false) else { return }
        
        self.parentViewController?.fistNameLabel.text = self.firstName
        self.parentViewController?.lastNameLabel.text = self.lastName
        self.parentViewController?.emailLabel.text = self.email
        self.parentViewController?.addressLabel.text = self.address
        self.parentViewController?.phoneNumberLabel.text = self.phoneNumber
        self.parentViewController?.cellNumberLabel.text = self.cellNumber
        self.parentViewController?.photoImageView.image = self.photo
        
        updateFavoriteState()
    }
    
    func changeFavoriteState() {
        self.contact.isFavorite = !self.contact.isFavorite
        updateFavoriteState()
    }
    
    // MARK: - Methods
    
    private func updateFavoriteState() {
        guard (self.parentViewController?.isViewLoaded() ?? false) else { return }
        
        self.parentViewController?.favoriteImageView.hidden = !self.contact.isFavorite
        switch (self.contact.isFavorite) {
        case true: self.parentViewController?.markAsFavoriteButton.setTitle("Usuń polubienie", forState: .Normal)
        case false: self.parentViewController?.markAsFavoriteButton.setTitle("Oznacz jako ulubiony", forState: .Normal)
        }
    }
    
}
