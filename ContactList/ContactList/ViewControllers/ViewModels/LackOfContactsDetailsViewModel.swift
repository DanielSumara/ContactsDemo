//
//  LackOfContactsDetailsViewModel.swift
//  ContactList
//
//  Created by Daniel Sumara on 12.09.2016.
//  Copyright © 2016 Sumara. All rights reserved.
//

import Foundation

class LackOfContactDetailsViewModel: DetailsViewModelProtocol {
    
    // MARK: - Properties
    
    weak var parentViewController: DetailViewController? {
        didSet {
            updateView()
        }
    }
    
    // MARK: - API
    
    func updateView() {
        guard (self.parentViewController?.isViewLoaded() ?? false) else { return }
        
        let lackOfData = "Brak kontaktów do zaprezentowania"
        
        self.parentViewController?.fistNameLabel.text = lackOfData
        self.parentViewController?.lastNameLabel.text = lackOfData
        self.parentViewController?.emailLabel.text = lackOfData
        self.parentViewController?.addressLabel.text = lackOfData
        self.parentViewController?.phoneNumberLabel.text = lackOfData
        self.parentViewController?.cellNumberLabel.text = lackOfData
        self.parentViewController?.photoImageView.image = nil
        
        updateFavoriteState()
    }
    
    func changeFavoriteState() {
    }
    
    // MARK: - Methods
    
    private func updateFavoriteState() {
        guard (self.parentViewController?.isViewLoaded() ?? false) else { return }
        
        self.parentViewController?.markAsFavoriteButton.setTitle("", forState: .Normal)
    }
    
}
