//
//  SearchTableCell.swift
//  BingSearch
//
//  Created by Alexey Belkevich on 20.03.16.
//  Copyright © 2016 Alexey Belkevich. All rights reserved.
//

import UIKit
import DTModelStorage

class SearchTableCell: UITableViewCell
{
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var itemImageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLabelLeadingConstraint: NSLayoutConstraint!
}

extension SearchTableCell: ModelTransfer
{
    func updateWithModel(model: SearchResult)
    {
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
        itemImageViewWidthConstraint.constant = model.image != nil ? 44 : 0
        titleLabelLeadingConstraint.constant = model.image != nil ? 8 : 0
    }
}
