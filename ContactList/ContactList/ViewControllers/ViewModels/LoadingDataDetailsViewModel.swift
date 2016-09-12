//
//  LoadingDataDetailsViewModel.swift
//  ContactList
//
//  Created by Daniel Sumara on 12.09.2016.
//  Copyright © 2016 Sumara. All rights reserved.
//

import Foundation

class LoadingDataDetailsViewModel: DetailsViewModelProtocol {
    
    // MARK: - Properties
    
    weak var parentViewController: DetailViewController? {
        didSet {
            updateView()
        }
    }
    
    // MARK: - API
    
    func updateView() {
        guard (self.parentViewController?.isViewLoaded() ?? false) else { return }
        
        self.parentViewController?.fistNameLabel.text = "Ładowanie danych..."
        self.parentViewController?.lastNameLabel.text = "Ładowanie danych..."
        self.parentViewController?.emailLabel.text = "Ładowanie danych..."
        self.parentViewController?.addressLabel.text = "Ładowanie danych..."
        self.parentViewController?.phoneNumberLabel.text = "Ładowanie danych..."
        self.parentViewController?.cellNumberLabel.text = "Ładowanie danych..."
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
