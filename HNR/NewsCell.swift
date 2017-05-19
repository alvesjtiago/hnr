//
//  NewsCell.swift
//  HNR
//
//  Created by Tiago Alves on 19/05/2017.
//  Copyright © 2017 Tiago Alves. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel:UILabel?
    @IBOutlet weak var countLabel:UILabel?
    @IBOutlet weak var authorLabel:UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
