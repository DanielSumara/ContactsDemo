//
//  TableViewCell.swift
//  ContactList
//
//  Created by Daniel Sumara on 06.09.2016.
//  Copyright © 2016 Sumara. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    class var Identifier: String { return String(self) }
    
    class func dequeueFrom<CellType: TableViewCell>(tableView: UITableView, forIndexPath indexPath: NSIndexPath) -> CellType {
        return tableView.dequeueReusableCellWithIdentifier(Identifier, forIndexPath: indexPath) as! CellType
    }
    
}
