//
//  DetailViewController.swift
//  ContactList
//
//  Created by Daniel Sumara on 06.09.2016.
//  Copyright © 2016 Sumara. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var fistNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var cellNumberLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!

    // MARK: - Properties

    var viewModel: DetailsViewModelProtocol? {
        didSet {
            self.viewModel?.parentViewController = self
            self.viewModel?.updateView()
        }
    }
    
    // MARK: - Lifecicle
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.viewModel?.updateView()
    }
    
    // MARK: - API
    
    // TODO: DRY
    func presentError(error: NSError) {
        // TODO: Handle error messages
    }

}

