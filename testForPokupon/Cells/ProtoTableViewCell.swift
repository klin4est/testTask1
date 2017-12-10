//
//  ProtoTableViewCell.swift
//  testForPokupon
//
//  Created by Stanislav Astakhov on 28.11.17.
//  Copyright © 2017 Stanislav Astakhov. All rights reserved.
//

import UIKit

class ProtoTableViewCell: UITableViewCell {
    // MARK: Private Properties
    @IBOutlet weak private var headerLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!

    //MARK: Public Methods
    func configure (headerText: String, descriptionText: String) {
        headerLabel.text = headerText
        descriptionLabel.text = descriptionText
    }
}
