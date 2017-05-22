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
    @IBOutlet weak var countLabel:RoundLabel?
    @IBOutlet weak var authorLabel:UILabel?
    
    func set(news: News) {
        self.titleLabel?.text = news.title
        self.countLabel?.text = String(describing: news.score!)
        
        if news.by != nil {
            let author = news.by
            let attrs = [NSFontAttributeName : UIFont(name: "AvenirNext-Bold", size: 14)!]
            let boldString = NSAttributedString(string: author!, attributes: attrs)
            
            let attributedString = NSMutableAttributedString(string:"by ")
            attributedString.append(boldString)
            
            self.authorLabel?.attributedText = attributedString
        }
    }

}
