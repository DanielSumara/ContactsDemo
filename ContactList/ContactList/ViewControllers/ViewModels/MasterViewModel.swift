//
//  MasterViewModel.swift
//  ContactList
//
//  Created by Daniel Sumara on 06.09.2016.
//  Copyright © 2016 Sumara. All rights reserved.
//

import UIKit

protocol MasterViewModelProtocol: UITableViewDataSource {
    
    weak var parentViewController: MasterViewController? { get set }
    
}

class MasterViewModel: NSObject, MasterViewModelProtocol {
    
    // MARK: - Properties
    
    weak var parentViewController: MasterViewController?
    
    private var dataManager: DataManagerProtocol
    
    private var dataSource: [ContactCellViewModel]?
    
    // MARK: - Lifecicle
    
    init(dataManager: DataManagerProtocol) {
        self.dataManager = dataManager
        
        super.init()
        
        dataManager.getContacts { [unowned self] result in
            switch (result) {
            case .Failure(let error):
                self.parentViewController?.presentError(error)
                self.dataSource = []
            case .Success(let data):
                self.dataSource = data.map { ContactCellViewModel(from: $0) }
            }
            
            dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                self.parentViewController?.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Properties
    
    
    
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dataSource = self.dataSource else { return 1 }
        if dataSource.count == 0 { return 1 }
        return dataSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let dataSource = self.dataSource else {
            return getLoadingCell()
        }
        guard dataSource.count != 0 else {
            return getLackOfDataCell()
        }
        
        let cell: ContactTableViewCell = ContactTableViewCell.dequeueFrom(tableView, forIndexPath: indexPath)
        cell.viewModel = dataSource[indexPath.row]
        return cell
    }
    
    // MARK: - Methods
    
    private func getLoadingCell() -> UITableViewCell {
        let loadingCell = UITableViewCell(style: .Default, reuseIdentifier: nil)
        loadingCell.textLabel?.text = "Trwa pobieranie danych"
        return loadingCell
    }
    
    private func getLackOfDataCell() -> UITableViewCell {
        let lackOfDataCell = UITableViewCell(style: .Default, reuseIdentifier: nil)
        lackOfDataCell.textLabel?.text = "Brak danych do zaprezentowania"
        return lackOfDataCell
    }
    
}
