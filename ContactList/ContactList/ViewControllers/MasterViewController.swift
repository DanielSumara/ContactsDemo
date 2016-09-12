//
//  MasterViewController.swift
//  ContactList
//
//  Created by Daniel Sumara on 06.09.2016.
//  Copyright © 2016 Sumara. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    
    // MARK: - Properties
    
    var viewModel: MasterViewModelProtocol! {
        didSet {
            self.viewModel.parentViewController = self
            self.tableView.dataSource = self.viewModel
            self.tableView.delegate = self.viewModel
        }
    }

    var detailViewController: DetailViewController? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
        
        self.viewModel.reloadView()
    }
    
    // TODO: DRY
    func presentError(error: NSError) {
        // TODO: Handle error
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetails" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
                
                controller.viewModel = self.viewModel.getDetailsViewModelForRow(indexPath.row)
                self.detailViewController = controller
            }
        }
    }
    
    // MARK: - Actions
    
    @IBAction func refreshTapped(sender: UIBarButtonItem) {
        self.viewModel.reloadData()
    }
    
    @IBAction func contactVisibilityChange(sender: UISegmentedControl) {
        self.viewModel.presentOnlyFavorites = sender.selectedSegmentIndex == 1
    }
    
}

