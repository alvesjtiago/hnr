//
//  JobCell.swift
//  HNR
//
//  Created by Tiago Alves on 17/09/2017.
//  Copyright © 2017 Tiago Alves. All rights reserved.
//

import UIKit

class JobCell: UITableViewCell {

    var job: Job?
    @IBOutlet weak var titleLabel:  UILabel?
    @IBOutlet weak var countLabel:  RoundLabel?
    @IBOutlet weak var authorLabel: UILabel?
    
    func set(job: Job) {
        self.job = job
        
        titleLabel?.text = job.title!
        countLabel?.text = String(describing: job.score!)
        
        if job.by != nil {
            let author = job.by!
            let attrs = [NSFontAttributeName : UIFont(name: "AvenirNext-Bold", size: 14)!]
            let boldString = NSAttributedString(string: author, attributes: attrs)
            
            let attributedString = NSMutableAttributedString(string:"by ")
            attributedString.append(boldString)
            
            authorLabel?.attributedText = attributedString
        }
    }

}
