//
//  ContactTableViewCell.swift
//  ContactList
//
//  Created by Daniel Sumara on 06.09.2016.
//  Copyright © 2016 Sumara. All rights reserved.
//

import UIKit

class ContactTableViewCell: TableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
    
    // MARK: - Properties
    
    var viewModel: ContactCellViewModelProtocol! {
        didSet {
            self.nameLabel.text = self.viewModel.firstName
            self.surnameLabel.text = self.viewModel.lastName
            self.thumbnail.image = self.viewModel.thumbnail
        }
    }
    
}
