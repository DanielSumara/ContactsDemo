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
    @IBOutlet weak var isFavoriteImage: UIImageView!
    
    // MARK: - Properties
    
    var viewModel: ContactCellViewModelProtocol? {
        didSet {
            oldValue?.parentCell = nil
            viewModel?.parentCell = self
        }
    }
    
    // MARK: - Lifecicle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.nameLabel.text = nil
        self.surnameLabel.text = nil
        self.thumbnail.image = nil
    }
    
}
